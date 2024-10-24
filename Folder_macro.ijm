// This is more dense in text, and reading "fluoro_macro.ijm" will allow you to understand what's going on better, if you're unfamiliar with the ImageJ macro language



                                                                                          //The function encompasses the entire processing, and runs on each file

function channels(input, output, filename, scale,zstack,c1,c2,c3){
                                                                                      	//First, it combines folder name and filename to get the file location
	input_name = input + filename; 
                                                                                        //Bioformats importer opens the file, and you can customise the colourizing, which series, etc
	run("Bio-Formats Importer", "open=input_name autoscale color_mode=Colorized view=Hyperstack stack_order=XYCZT Series_1");
	if (zstack=="yes") {
                                                                                        //If it is a z-stacked image, it is z-projected for max intensity
		run("Z Project...", "projection=[Max Intensity]");
	}else {
                                                                                        //otherwise skipped
		continue
	}
	                                                                                      //title is obtained here since it would have changed depending on whether it was z-projected or not
	title = getTitle();
	rename(filename);                                                                     //ensures that this file can be called whenever we selectWindow(filename)
	selectWindow(filename);
	print(filename);                                                                      //prints the image currently being processed
	
	run("Scale Bar...", scale);                                                           //Adds a scale bar, then splits image into coloured channels
	run("Split Channels"); 

	
	selectWindow("C1-" + filename);                                                       //First channel, when split, gets renamed into "C1-...the old file name". So first we select that
	run(c1);                                                                              //We then recolour it to the colour chosen (default: red)
	x = "C1-"+filename;
	saveAs(filetype, output + filename + "_" + c1);                                       //It is then renamed and saved in the output folder as 'filename_channel.filetype' (e.g. 'c1_red.png')
	
	selectWindow("C2-"+filename);                                                        //Similarly for the other channels
	run(c2);
	y = "C2-" + filename;
	saveAs(filetype, output + filename + "_" + c2);
	
	if (c3 !="*None*") {                                                                //If there are less than 3 channels, this step is skipped, that's all
		selectWindow("C3-"+filename);
		run(c3);
		z = "C3-"+filename;
		saveAs(filetype, output + filename + "_" + c3);
		
			
		run("Merge Channels...", "c1=" + y + " c2=" + z + " c3=" + x + " keep");          //Merge has the worst syntax known to mankind.
		run("Scale Bar...", scale);
		saveAs(filetype, output + filename + "_composite");
	}else {		
		run("Merge Channels...", "c1=" + x + " c2=" + y + " keep");                       //If only two channels, only they are merged.
		run("Scale Bar...", scale);
		saveAs(filetype, output + filename + "_composite");
	}	
	close("*");                                                                         //close closes all the open windows, may save RAM.
}



input = "E:/";                                                                        //Default input and output folders are set.
output = "E:/";



                                                        // THIS NEXT PART CREATES A DIALOGUE BOX, AND IS WHERE THE USER SETS THE VARIABLES:

Dialog.create("NB's Macro");                                                          //Title of the dialog box

Dialog.addDirectory("Input Folder Path",input);                                       //First you initialise all the inputs, be they locations (addDirectory) or dropdowns (addChoice) and so on.
Dialog.addDirectory("Output Folder (Should not be the same as input)", output)
Dialog.addChoice("Scale bar in um", newArray("20um","50um","10um"),"20um");
Dialog.addChoice("File type", newArray("Jpeg"));//, "png","tif"), "jpg");
                                                                                      //I've left some commented options that you can also use
//Dialog.addRadioButtonGroup("Show advanced options?", newArray("yes","no"), 1, 2, "yes");
Dialog.show()

                                                                                      //ONCE THE DIALOG BOX IS CLOSED (by clicking ok) THE SUBMITTED ANSWERS ARE SAVED HERE, IN ORDER.
                                                                                      //Thus, the number of inputs have to match the no of variables, and they are parsed only after you click OK
input=Dialog.getString();
output= Dialog.getString(); 
scalebar = Dialog.getChoice();
filetype = Dialog.getChoice();
//default= Dialog.getRadioButton();
                                                                                      //Based on the output of the scalebar question, the variable 'scale' is set
if (scalebar=="20um") {
	scale = "width=20 height=10 thickness=4 font=30 color=White background=None location=[Lower Right] horizontal bold overlay";
}if (scalebar == "50um"){
	scale = "width=50 height=10 thickness=4 font=30 color=White background=None location=[Lower Right] horizontal bold overlay";
}if (scalebar=="10um") {
	scale = "width=10 height=10 thickness=4 font=30 color=White background=None location=[Lower Right] horizontal bold overlay";
}

                                                                                      //Once that is done, the next dialog box renders, similarly
//THIS IS ANOTHER DIALOG BOX, SO YOU CAN SPECIFY WHETHER TO Z-STACK OR NOT, SPECIFY  WHICH CHANNEL GOES WHERE
Dialog.create("Thakur Lab's Micro Macro");
Dialog.addRadioButtonGroup("Z-Stack?", newArray("yes","no"), 1, 2, "yes");
Dialog.addMessage("Please specify which colour you want each channel to be");
Dialog.addChoice("Channel 1", newArray("Red","Green","Blue","Grays","Magenta"), "Red");
Dialog.addChoice("Channel 2", newArray("Red","Green","Blue","Grays","Magenta"), "Green");
Dialog.addChoice("Channel 3", newArray("Red","Green","Blue","Grays","Magenta","*None*"), "Grays");
Dialog.show()

zstack = Dialog.getRadioButton();
c1= Dialog.getChoice();
c2= Dialog.getChoice();
c3= Dialog.getChoice();

                                                                                    //This actually runs the macro and allows for running in batch fashion: i.e: multiple files
setBatchMode(true);
list = getFileList(input);                                                          //Every file in the directory is listed in list
print("Please ignore the error message at the end. Processing complete for:")       //Unfortunately, I never figured out this annoying error message that popped up even on successful processing of all images.


for (i=0;i<list.length;){
	channels(input,output,list[i],scale,zstack,c1,c2,c3);                             //The function we called at the start is called for each file in the list
	i++;
}
setBatchMode(false);
                                                                                    //Good luck! Check the ImageJ macro documentation, and the troubleshooting tips I've left in the README
