# Si for each subject
DataSigma_List_f<-function(XData_list){
  N=length(XData_list)
  DataSigma_list<-list()
  for(i in 1:N){
    Xdata_i<-XData_list[[i]]
    ni<-nrow(Xdata_i)
    ####Calculate Si
    dataSigma_i<-cor(Xdata_i)
    ###########list
    dataName<-paste("XData",i)
    DataSigma_list[[dataName]][["Si"]]<-as.matrix(dataSigma_i)
    DataSigma_list[[dataName]][["ni"]]<-ni
  }
  return(DataSigma_list)
}

##################################################
# EM algorithm for Transferred GGM
EM_TL_list_f<-function(XData_list,h,lambda,IC_Algorithm,e=1e-8){
  p=ncol(XData_list[[1]])
  N=length(XData_list)
  
  DataSigma_List<-DataSigma_List_f(XData_list)
 
  ###Initialization Thetas for each subject
  Thetai_list<-list()
  for(i in 1:N){
    dataName<-paste("XData",i)
    Si=DataSigma_List[[dataName]][["Si"]]
    Thetai_list[[i]]<-solve(Si)
  }
  Thetai_list0<-Thetai_list

  #######
  j=0;
  repeat{
    j=j+1;
    Sit_list<-list()
    for(i in 1:N){
      dataName<-paste("XData",i)
      ni<-DataSigma_List[[dataName]][["ni"]]
      Si=DataSigma_List[[dataName]][["Si"]]
      Si=(Si+t(Si))/2
      Sit<-(ni*Si+(N*h-p-1)*solve(Sum_Theta_f(Thetai_list)))/(h-p-1+ni)
      Sit<-(Sit+t(Sit))/2
      Sit_list[[i]]<-Sit
    }
    if(IC_Algorithm=="BCD"){
      # ###desent
      # Q <- matrix(1, p, p)
      # S=Spie
      # BCD_result<-BCD_f(Q=S,Rho=lambda,Sig=S,epsilon=1e-6)
      # Theta2t0 <- BCD_result$Sig;
      print('Please use gLasso currently; BCD needs further checking')
      break
    }else if(IC_Algorithm=="gLasso"){
      for(i in 1:N){
        S=as.matrix(Sit_list[[i]])
        # mm <-glasso(S, lambda, zero=NULL, thr=1.0e-4, maxit=1e2, approx=FALSE,
        #          penalize.diagonal=TRUE, start="warm",
        #          w.init=solve(Thetai_list0[[i]]),wi.init=Thetai_list0[[i]], trace=FALSE)
        
        mm <-glasso(S, lambda, zero=NULL, thr=1.0e-8, maxit=1e3, approx=FALSE,
                   penalize.diagonal=TRUE, start=c("cold","warm"),
                   w.init=NULL,wi.init=NULL, trace=FALSE)
        wi<-mm$wi
        Thetai_list0[[i]]<-(wi+t(wi))/2
      }
    }else{
      print("Please enter the correct algorithm name for IC")
      break;
    }
    
    if(Converge_f(Thetai_list0,Thetai_list)<e | j>50){
        break;
      }
    Thetai_list=Thetai_list0; 
    # print(paste('subEM_iter = ', j));
  }###End repeat
  print(paste('EM_iter = ', j));
  
  # calculate partial correlations
  partiali_list=lapply(Thetai_list,cov2cor_f)
  
  return(list(Thetai_list = Thetai_list,partiali_list=partiali_list, Sit_list = Sit_list, iter = j))
}
# partial correlation function
cov2cor_f<-function(Theta){
 return(-cov2cor(Theta))
}

Converge_f<-function(Thetai_list0,Thetai_list){
  N=length(Thetai_list)
  i=1
  Thetai_diff<-Thetai_list0[[i]]-Thetai_list[[i]]
  Sum_Theta_diff<-norm_f(Thetai_diff,'2')
  for(i in 2:N){
    Thetai_diff<-Thetai_list0[[i]]-Thetai_list[[i]]
    Sum_Theta_diff<-Sum_Theta_diff+norm_f(Thetai_diff,'2')
  }
  return(Sum_Theta_diff)
}

Sum_Theta_f<-function(Thetai_list){
  N=length(Thetai_list)
  Sum_Theta<-Thetai_list[[1]]
  for(i in 2:N){
    Thetai<-Thetai_list[[i]]
    Sum_Theta<-Sum_Theta+Thetai
  }
  return(Sum_Theta)
}
norm_f<-function(Theta,type){
  if(type=='1'){
    v=sum(abs(Theta))
  }
  if(type=='2'){
    v=sum(Theta^2)
  }
  return(v)
}
