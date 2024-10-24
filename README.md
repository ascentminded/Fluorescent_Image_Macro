# Fluorescent_Image_Macro
A few ImageJ macros developed for the processing of fluorescent microscope images. These were built with tissue images in mind, and might be lab specific, so you might need to tweak them. All in all, very intuitive

* Primarily concerned with splitting files into different colour channels, creating a composite, adding scale bars, and saving them all in one location. 
* *fluoro_macro.ijm* is for an individual image that is currently open in ImageJ
* *folder_macro.ijm* automatically processes an entire folder and saves the output in a designated folder.

**Troubleshooting**
- Remember to keep your input and output folders separate.
- Check if the metadata folders are present alongside the main files, otherwise scale bars won't be accurate.

- Remember that ImageJ is built on Java and struggles with spaces. This means that even a single space in a file location can cause problems in the code.
- So, "D:/A Folder/file name.vsi" won't work, but "D:/A_Folder/file_name.vsi" will.

- An egregious example of java syntax is the command `run("Merge Channels...", "c1=" + x + " c2=" + y + " c4=" + z);`, which requires you to place quotes in very counterintuitive places. Frustrating, I know.

- Make sure that actions are being performed on the correct image
- selectWindow('window_name') will help you here. As you go through the image processing steps, you may notice that the window that is selected by default is not the one you want, so run through it once manually.

- Run through the entire code in sequence, 'fluoro_macro' should help you process one (currently open) image, while 'folder_macro' runs the identical process on an entire folder of images.
- The ability to process an entire folder without rendering each image is a huge time saver, and the main use of this macro, but this automation comes with some issues.
- Specifically, I've built a macro that reads each file title and processes the file accordingly, but debugging it has been a pain.
