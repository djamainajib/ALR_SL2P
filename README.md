# ALR_SL2P

Active Learning Regularization algorithm
----------

This is an Active Learning Regularization (ALR) approach proposed to regularize vegetation biophysical variables (LAI, FCOVER, FAPAR, CCC and CWC) derived from Sentinel-2 MSI images using SL2P processor [1]. 
ALR selects a set of Vegetation Indices from a provided library of candidates using a feature selection approach (LASSO, [2]) for training one Artificial Neural Networks for each product in order to provide new estimates for invalid (flagged) SL2P estimates and outliers from the same product.  

The code generates also a Quality Indicator map (flags map) for each regularized product.   
 
Content:
--------
- README.md: the actual document.
- ALR.m : the main code.
- tools: containing aux_data and auxiliary code pieces.
- Samples_input_data: samples of S2L2A and S2L2B data

Inputs:
-------
- S2L2A product in .SAFE format.
- S2L2B product obtained using SL2P and the corresponding flags map (.tif format).

Outputs:
-	Regularized product
-	QAI (flag maps)
-	.xls file resuming the used database
If output path not specified (optional), outputs will be saved in the inputs path.  

Usage:
Matlab ALR [S2L2A path] [S2L2B path] [biophysical variable: lai, fcover, fapar, cwc, ccc] [output_path\ (optional)]'

Example:
--------
Matlab ALR( '.\ Samples_input_data\S2A_MSIL2A_20180620T173121_N0206_R055_T14UNV_20180620T225537.SAFE\', '.\ Samples_input_data\S2A_MSIL2B_20180620T173121_N0206_R055_T14UNV_20180620T225537\', 'lai');

References:
-----------
[1] Weiss, M.; Baret, F. S2ToolBox level 2 products, version 1.1. 2016. [https://step.esa.int/docs/extra/ATBD_S2ToolBox_L2B_V1.1.pdf].
[2] Least Absolute Shrinkage and Selection Operator regression (LASSO), MATLAB Machine Learning Toolbox, https://www.mathworks.com/help/stats/lasso.html (Accessed in December 2019).

 

 

