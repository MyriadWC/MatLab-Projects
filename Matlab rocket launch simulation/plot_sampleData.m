function[]=plot_sampleData()

    clear all
    clc
    close all
    
    % reference: Moeller & Reif (2000) Poket Atlas of Sectional Anatomy
    %  CT and MRI vol.2
    
    % =============the raw velocity coordinate system==============
    % AXfh: foot-head, 80
    % AXrl: right-left, 46/42
    % AXfb: front-back, 80
    % RIGHT-HAND SYSTEM
    
    % but the raw image volume stacking direction is not in consistent with 
    % the velocity, therefore need to flip along AXfh and AXrl
    
    % Additionally, to make it intuitive, i.e. incdices increasing from
    % back to front, also need to flip along AXfb, and then put
    % negative sign in front of velocity AXfb
    
    % Newly adopted axis-system:
    % AXfh: foot-head, as x-axis, 80
    % AXbf: back-front, as y-axis, 80
    % AXrl: right-left, as z-axis, 46/42
    % RIGHT-HAND SYSTEM
    % patient lying facing upword, view fron his lhs
    
    % the 4D matrix dimension is [AXbf,AXfh,AXrl,phase]
    %==============================================================
    
    %&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    % there is a spot in the descending AO where velocity is upwards,
    % wield
    %&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
        

    tpR=0.052; % time resolution 0.052sec
    spR=3; % spatial resolution 3mm
    SmTp='gaussian'; %smooth type velocity, gaussian or box
    Smkz=3;
    %&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 


    load sampleData

    %---------------------------------------
    % define axes using the given resolution
    [Nbf,Nfh,Nrl,Nph]=size(MAG);
    %---------------------------------------

    Mag=MAG/1e7; %arbitrary, otherwise too large numbers
    %>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    % magnitude
    %Mag=AA.Mag;    
    Mag=flipdim(Mag,1); % flip along AXbf
    Mag=flipdim(Mag,2); % flip along AXfh
    Mag=flipdim(Mag,3); % flip along AXrl
    %---------------------------------------
    % define axes using the given resolution
    tsp=(0:(Nph-1))*tpR;
    AXbf=(0:(Nbf-1))*spR;
    AXfh=(0:(Nfh-1))*spR;
    AXrl=(0:(Nrl-1))*spR;
    [mx,my,mz]=meshgrid(AXbf,AXfh,AXrl);
    %>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    for Ntsh=Nph

        Mag3D(:,:,:)=Mag(:,:,:,Ntsh);


        %>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        % velocity

        Velbf(:,:,:)=VAP(:,:,:,Ntsh); % cm/s
        Velfh(:,:,:)=VFH(:,:,:,Ntsh);
        Velrl(:,:,:)=VRL(:,:,:,Ntsh);

        Velbf=flipdim(Velbf,1); % flip along AXbf
        Velbf=flipdim(Velbf,2); % flip along AXfh
        Velbf=flipdim(Velbf,3); % flip along AXrl
        Velfh=flipdim(Velfh,1); % flip along AXbf
        Velfh=flipdim(Velfh,2); % flip along AXfh
        Velfh=flipdim(Velfh,3); % flip along AXrl
        Velrl=flipdim(Velrl,1); % flip along AXbf
        Velrl=flipdim(Velrl,2); % flip along AXfh
        Velrl=flipdim(Velrl,3); % flip along AXrl
        % flip because volume stacking sequence is not consistent with velocity
        % (+/-)

        VelbfR=Velbf/100; % convert to m/s
        VelfhR=Velfh/100;
        VelrlR=Velrl/100;

        VelbfR=-VelbfR; % according to change of axis on this direction
        
        VelfhR=smooth3(VelfhR,SmTp,Smkz);
        VelbfR=smooth3(VelbfR,SmTp,Smkz);
        VelrlR=smooth3(VelrlR,SmTp,Smkz);
            
        Vel_mag=sqrt(VelfhR.^2+VelbfR.^2+VelrlR.^2);
    end   
    Mag2D(:,:)=Mag3D(48,:,:);
    figure,
    imagesc(AXrl,AXfh,Mag2D);
    axis equal
    axis('xy');
    %axis off
    colormap gray
    
    figure,
    Velmag2D(:,:)=Vel_mag(48,:,:);
    [h1,c1]=contourf(AXrl,AXfh,Velmag2D,30);
    axis equal
    set(c1,'linestyle','none'); %caxis([0 1.0]);
    colormap(flipud(hot));
    %axis off
    

end
