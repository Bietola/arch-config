import XMonad

main = xmonad defaultConfig
        { modMask = mod4Mask
        , terminal = "st"
        }
