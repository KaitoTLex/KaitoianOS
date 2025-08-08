{ lib
, fetchFromGitLab
, mesa
}:

(mesa.override {
  galliumDrivers = [ "swrast" "asahi" "virgl" "zink" ];
  vulkanDrivers = [ "swrast" "asahi" ];
  vulkanLayers = [ "device-select" "overlay" ];
  eglPlatforms = [ "x11" "wayland" ];
  withValgrind = false;
  enablePatentEncumberedCodecs = true;
}).overrideAttrs (oldAttrs: {
  version = "25.0.0-asahi";
  src = fetchFromGitLab {
    # tracking: https://pagure.io/fedora-asahi/mesa/commits/asahi
    domain = "gitlab.freedesktop.org";
    owner = "asahi";
    repo = "mesa";
    rev = "asahi-20241211";
    hash = "sha256-Ny4M/tkraVLhUK5y6Wt7md1QBtqQqPDUv+aY4MpNA6Y=";
  };

  mesonFlags = let
    badFlags = [
      "-Dinstall-mesa-clc"
      "-Dopencl-spirv"
      "-Dgallium-nine"
    ];
    isBadFlagList = f: builtins.map (b: lib.hasPrefix b f) badFlags;
    isGoodFlag = f: !(builtins.foldl' (x: y: x || y) false (isBadFlagList f));
  in (builtins.filter isGoodFlag oldAttrs.mesonFlags) ++ [
      # we do not build any graphics drivers these features can be enabled for
      "-Dgallium-va=disabled"
      "-Dgallium-vdpau=disabled"
      "-Dgallium-xa=disabled"
      "-Dxlib-lease=disabled"
      # does not make any sense
      "-Dandroid-libbacktrace=disabled"
      "-Dintel-rt=disabled"
      # do not want to add the dependencies
      "-Dlibunwind=disabled"
      "-Dlmsensors=disabled"
      # add options from Fedora Asahi's meson flags we're missing
      # some of these get picked up automatically since
      # auto-features is enabled, but better to be explicit
      # in the same places as Fedora is explicit
      "-Dgallium-opencl=icd"
      "-Dgallium-rusticl=true"
      "-Dgallium-rusticl-enable-drivers=asahi"
      "-Degl=enabled"
      "-Dgbm=enabled"
      "-Dopengl=true"
      "-Dshared-glapi=enabled"
      "-Dgles1=enabled"
      "-Dgles2=enabled"
      "-Dglx=dri"
      "-Dglvnd=enabled"
      # enable LLVM specifically (though auto-features seems to turn it on)
      # and enable shared-LLVM specifically like Fedora Asahi does
      # perhaps the lack of shared-llvm was/is breaking rusticl? needs investigation
      "-Dllvm=enabled"
      "-Dshared-llvm=enabled"
      # add in additional options from mesa-asahi's meson options,
      # mostly to make explicit what was once implicit (the Nix way!)
      "-Degl-native-platform=wayland"
      "-Dandroid-strict=false"
      "-Dpower8=disabled"
      "-Dvideo-codecs=vp9dec"
      # save time, don't build tests
      "-Dbuild-tests=false"
      "-Denable-glcpp-tests=false"
    ];

  # replace patches with ones tweaked slightly to apply to this version
  patches = [
    ./opencl.patch
  ];

  postInstall = (oldAttrs.postInstall or "") + ''
    # we don't build anything to go in this output but it needs to exist
    touch $spirv2dxil
  '';
})
