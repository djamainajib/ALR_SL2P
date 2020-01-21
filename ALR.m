function SL2P_Regularizing(varargin)

%% 1. Initialization
if ~ismember(nargin,[3,4]), 
    disp({'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!';
        '--usage : Matlab SL2P_Regularizing [S2L2A tiff data folder] [S2L2B tiff data folder] [biophysical variable: lai, fcover, fapar, cwc, ccc] [output_path\ (optional)]'})
    return; 
end;
addpath(genpath('.\SL2P_regularizing-master\tools'));
file_name=strsplit(varargin{2},'\');
file_name=file_name{end-1};

database_1.DEF.percentile=2.5;
database_1.DEF.bio_clas_num=100;
%% 2. VI_selection
[database_1,VI]=VI_selection(varargin,database_1);

%% 3. Regularizing........................................................
database_1.Predictors = database_1.Lasso.FitInfo.PredictorNames(database_1.Lasso.B(:,database_1.Lasso.idx(3))~=0);
database_1=create_training_database(database_1,VI);  
database_1=regularize_bio(database_1);

%% 4 Create output path..........................................
if nargin==5,   
   out_path=[varargin{4},'\'];
   else,
       out_path=varargin{2};
       out_path=[out_path(1:end-1),'_reg\'];
end;

if ~isfolder(out_path), 
    mkdir (out_path); 
end; 
%% 5 Exporting.......................................................
filename = [out_path,varargin{3},'.xlsx'];
xlswrite(filename,[{'Variable: '},database_1.bvar],'Start','A1');
xlswrite(filename,[{'VIs: '},database_1.Predictors],'Start','A2');
xlswrite(filename,[{'Theo. RMSE :'},{database_1.NET.RMSE(1)},{database_1.NET.RMSE(2)}],'Start','A3');
xlswrite(filename,[{'Image dim. :'},{size(database_1.all,1)}],'Start','A4');
xlswrite(filename,[{'N_calibration :'},{size(database_1.learn,1)}],'Start','A5');
xlswrite(filename,[{'N_regularizing :'},{size(database_1.reg,1)}],'Start','A6');
xlswrite(filename,[{'N_no_veg_bare :'},{size(database_1.reg_CL,1)}],'Start','A7');
%%
export_reg_data(database_1, [out_path,file_name]);
end

