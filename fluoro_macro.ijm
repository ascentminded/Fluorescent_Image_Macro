output = "E:/Folder/Proc/";   				//Sets an output folder
input = getInfo("image.filename");			
title = getTitle();					//Identifies the title of the currently open image
rename(title);						//Doubly ensures that the file can be called by this 'title'

c1 = "Red";						//Default settings of colours for each channel, can be changed to suit yourself
c2 = "Green";
c3 = "Blue";

							//Initialise the scale bar length, location and thickness
scale = "width=20 height=10 thickness=4 font=40 color=White background=None location=[Lower Right] horizontal bold overlay" 
							
							//Z-project a z-stacked image based on max intensity. Comment or remove this line if the image isn't z-stacked
							//rename("MAX_" + title); should be added instead if it's not z-stacked
run("Z Project...", "projection=[Max Intensity]");

selectWindow("MAX_"+title);
							//Adds a scale bar to the z-projected image
run("Scale Bar...", scale);
run("Split Channels"); 					//Splits the hyperstacked image into the constituent channels, scale bar will be on all of them.

				
selectWindow("C1-MAX_"+title); 				//First channel, when split, gets renamed into "C1-...the old file name". So first we select that
run(c1); 						//We then recolour it red (i.e: c1, c2 and c3 can be "Red", "Blue","Green" or Grey")
 x = "C1-MAX_"+title;
saveAs("Jpeg", output + input + "_" + c1);

							//We then save it as an image, to the output folder, with the suffix "_red" (or whatever c1 is) to indicate the channel
selectWindow("C2-MAX_"+title);
run(c2);
y = "C2-MAX_"+title;
saveAs("Jpeg", output + input + "_" + c2);		//You can replace "Jpeg" with "PNG" or "tif"

selectWindow("C3-MAX_"+title);
run(c3);
z = "C3-MAX_"+title;
saveAs("Jpeg", output + input + "_" + c3);

//run("Merge Channels...", "c1=" + stack2 + " c7=" + stack2);  is apparently the syntax for Merge channels . yeah, I don't understand why either.  
// Here, c1, c7, etc denote the colours, and you should look at ImageJ's merge channels to identify which is which.

run("Merge Channels...", "c1=" + x + " c2=" + y + " c4=" + z);
run("Scale Bar...", "width=20 height=10 thickness=4 font=40 color=White background=None location=[Lower Right] horizontal bold overlay");
saveAs("Jpeg", output + input + "_composite");
close("*");
