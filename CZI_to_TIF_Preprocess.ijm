// ImageJ macro for batch processing of .czi files

input_directory = "C:/path/to/input/folder/";
output_directory = "C:/path/to/output/folder/";
weka_model = "C:/path/to/your/weka/model.model";

list = getFileList(input_directory);

for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], ".czi")) {
        // Open the .czi file using Bio-Formats
        open(input_directory + list[i]);

        // Preprocess the image (e.g., split channels, adjust brightness/contrast, denoise)
        run("Split Channels");
        selectWindow("C1-" + getTitle());
        setMinAndMax(0, 255);  // Adjust the min and max values according to your images

        // Apply a Gaussian blur filter
        run("Gaussian Blur...", "sigma=2");

        // Segment the image using the Trainable Weka Segmentation plugin
        run("Trainable Weka Segmentation", "open=" + weka_model + " classify");

        // Save the segmentation result
        saveAs("Tiff", output_directory + "Segmented_" + list[i] + ".tif");

        // Close all open windows
        run("Close All");
    }
}
