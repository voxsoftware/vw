
var installDir = process.argv[2];
var fs= require("fs");
fs.copySync(process.argv[0], installDir + "/vwdata/jx");