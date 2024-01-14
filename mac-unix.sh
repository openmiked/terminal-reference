#--- Google Chrome: Helpful Commands ---#
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
     --user-data-dir="$HOME/proxy-profile" \
     --proxy-server="socks5://localhost:<socks-tunnel-port>"        # Open Chrome using SOCKS tunnel with port forwarding