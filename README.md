# Intensity_analysis

This script find the intensity of the selected objects in the original grayscale image.

## Scripts
-	The two needed scripts should be saved into the same folder (i.e **Scripts**).
-	Does not need to be the folder where the images are located.
-	Scripts required:
    -	**Intensity_analysis.m**
    -	**read_stackTiff.m**

## Inputs
-	The script can analyse multiple channels (the same case, different stains).
-	The script can analyse 2D and 3D images.
-	The input folder should contain the greyscale image (image_name **_Channel**) and the segmented image (image_name **_Channel_mask**).
-	IMPORTANT: the segmented image should have the same name as the greyscale image with “**_mask**” at the end.
-	Be sure that the name of the channel is not included in the case name (image_name).
-	Example:

![image](https://user-images.githubusercontent.com/29541710/162402154-657289d5-463b-4806-9de2-5d0e056b7dee.png)

There are two cases (SD04317 and SD06113) and each case have two channels (sv2a50 and syph)

## Run the script
-	Run **Intensity_analysis.m** in Matlab.
-	It will ask the folder where the images are located.
-	That’s all!

## Output
-	It creates a new folder into the input folder called **Intensity_results** that contains:
    -	**All_objects_Intensity.csv**. Mean intensity and Area of every object per every case.
    -	**Summary_Intensity.csv**. Mean intensity, Median intensity and Area of all objects per every case.


