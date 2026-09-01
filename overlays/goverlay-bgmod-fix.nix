final: prev: {
  goverlay = prev.goverlay.overrideAttrs (oldAttrs: {
    dontWrapQtApps = true;
    postFixup = (oldAttrs.postFixup or "") + ''
      install -Dm755 $out/libexec/bgmod $out/share/goverlay/bgmod/bgmod
      install -Dm755 $out/libexec/bgmod-uninstaller $out/share/goverlay/bgmod/bgmod-uninstaller
      wrapQtApp "$out/libexec/goverlay"
    '';
  });
}
