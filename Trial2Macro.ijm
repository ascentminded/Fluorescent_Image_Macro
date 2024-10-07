output = "E:/NaveenTrial2/Proc/";
input = getInfo("image.filename");
title = getTitle();
title = title.substring(0, title.length - 20);
rename(title);

c1 = "Blue";
c2 = "Green";
c3 = "Red";

scale = "width=20 height=10 thickness=4 font=40 color=White background=None location=[Lower Right] horizontal bold overlay" 
//scale = "width=50 height=10 thickness=4 font=30 color=White background=None location=[Lower Right] horizontal bold overlay"

run("Z Project...", "projection=[Max Intensity]");
//open(input + input);	// also works to import images , but it would open a bio-format window that would ask for specifics. Namely, hyperstack and colorized)
selectWindow("MAX_"+title);

run("Scale Bar...", scale);
run("Split Channels"); //Splits the hyperstacked image into the three channels

				//We then add a scale bar to the bottom right of this image
selectWindow("C1-MAX_"+title); //First channel, when split, gets renamed into "C1-...the old file name". So first we select that
run(c1); //We then recolour it red
x = "C1-MAX_"+title;
saveAs("Jpeg", output + input + "_" + c1);

				//We then save it as an image, to the output folder, with the suffix "_red" to indicate the channel
selectWindow("C2-MAX_"+title);
run(c2);
y = "C2-MAX_"+title;
saveAs("Jpeg", output + input + "_" + c2);	

selectWindow("C3-MAX_"+title);
run(c3);
z = "C3-MAX_"+title;
saveAs("Jpeg", output + input + "_" + c3);

//run("Merge Channels...", "c1=" + stack2 + " c7=" + stack1);  is apparently the syntax for Merge channels . yeah, I don't understand why either. 
run("Merge Channels...", "c1=" + x + " c2=" + y + " c4=" + z);
run("Scale Bar...", "width=20 height=10 thickness=4 font=40 color=White background=None location=[Lower Right] horizontal bold overlay");
saveAs("Jpeg", output + input + "_composite");
close("*");