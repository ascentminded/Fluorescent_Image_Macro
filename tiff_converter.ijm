input = "E:/Input/";                         //Change these to match your folders
output = "E:/Input/Processed/";

function channels(input, output, filename){
	input_name = input + filename; 
	run("Bio-Formats Importer", "open=input_name autoscale color_mode=Default view=Hyperstack stack_order=XYCZT Series_1");
	saveAs("Tiff", output + filename + "_R");
	
	
	close("*");
}

setBatchMode(true);
list = getFileList(input);
for (i=0;i<list.length;){
	channels(input,output,list[i]);
	i++;
}
setBatchMode(false);
