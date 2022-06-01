######   Solve Transferred Gaussian Graphical Model (Transferred GGM) 
# - application paper (Chong, et al., 2019)
# - original paper (Huang, et al., 2012)
#   Training Input:
#   XData_list: Training data X from each subject
#   h: parameter of the Wishart distribution
#   lamda: tuning paramter
#   IC_Algorithm: method of solving the optimization (M step) within EM algorithm. IC_Algorithm="gLasso" or "BCD"

#   Training Output:
#   Thetai_list: estimated graphs for each subject
#   partiali_list: estimated partial correlations for each subject


# Written by Lujia Wang @ Georgia Tech


# library('glasso')
rm(list=ls(all=TRUE));
root="C:\\github\\Transferred Gaussian Graphical Model\\"
source(paste(root,"EM_TL_list_f.R",sep=""))

######### data reading from each subject
XData_list_f<-function(file_list_path){
  file_list<- list.files(file_list_path)
  XData_list<-list()
  i=0
  for (file_name in file_list){
    i=i+1
    file<-paste(file_list_path,file_name,sep="")
    Xdataset_i <-read.csv(file);dim(Xdataset_i)
    XData_list[[i]]<-Xdataset_i
  }
  return(XData_list)
}

####################################### data path
file_list_path<-"C:\\github\\Transferred Gaussian Graphical Model\\Simulation data\\"
######### data reading from each subject
XData_list<-XData_list_f(file_list_path)
################EM 
h=100
lambda=0.1
IC_Algorithm="gLasso"
EM_result<-EM_TL_list_f(XData_list,h,lambda,IC_Algorithm)
# graphical networks for each subject
Thetai_list= EM_result$Thetai_list
# partial correlations for each subject
partiali_list=EM_result$partiali_list
