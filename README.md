# aria2gui
默认是以“aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all -c -D -d /Users/Nick/Downloads/Aria2”命令运行
因此及到一个默认下载分区的设置，请自行修改成你自己的路径，不太懂编程，也许有更好的解决办法，欢迎大家指正。
打开https://github.com/yangshun1029/aria2gui/blob/master/MacGap/AppDelegate.m，
NSArray *arguments;
arguments = [NSArray arrayWithObjects: @"--enable-rpc", @"--rpc-listen-all=true", @"--rpc-allow-origin-all", @"-c", @"-D", @"-d /Users/Nick/Downloads/Aria2", nil];
修改红色部分为你自己的路径
