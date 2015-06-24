function [output_df2, output_bqf, noise_df2, noise_bqf] = estimate_noise_file(signal, iir)

	n_iir=length(iir)
	len=length(signal)
    output_df2=zeros(1,len);
	output_bqf=zeros(1,len);
    noise_df2=zeros(1,len);
    noise_bqf=zeros(1,len);
%     noise_df2_single=zeros(1,len);
%     noise_bqf_single=zeros(1,len);
	fid=fopen('take_data.txt','w');
	if fid == -1
	     	disp(['Unable to open file take_data.txt']);
        	return
    end
   
	for i=1:n_iir
        	fprintf(fid,'online_filters= \n');
        	fprintf(fid,'number: %d\n',iir(i).number);
        	fprintf(fid,'order: %d\n',iir(i).order);
        	fprintf(fid,'g: %ld\n',iir(i).g);
        	fprintf(fid,'sos: %ld %ld %ld %ld\n',iir(i).sos(:,1),iir(i).sos(:,2),iir(i).sos(:,3),iir(i).sos(:,4));
    end
        
  
	fclose(fid);

	fid=fopen('take_data_signal.txt','w');
	if fid == -1
		disp(['Unable to open file take_data_signal.txt']);
        return
    end
    fprintf(fid,'%d\n',length(signal));
	for i=1:length(signal)
        fprintf(fid,'%ld\n',signal(i));
    end
        
	fclose(fid);
	!./est

    pause(2);
    
    fid=fopen('give_data.txt','r');
    if fid == -1
        disp(['Error reading file']);
        return
    end
    for i=1:n_iir
        
        for j=1:len
	        A=fscanf(fid,'%s',1);
        	output_df2(j)=str2double(A);
        
        	A=fscanf(fid,'%s',1);
        	output_bqf(j)=str2double(A);
        
        	A=fscanf(fid,'%s',1);
        	noise_df2(j)=str2double(A);
        
        	A=fscanf(fid,'%s',1);
        	noise_bqf(j)=str2double(A);
            
%             
%         	A=fscanf(fid,'%s',1);
%         	noise_df2_single(j)=str2double(A);
%             
%             
%         	A=fscanf(fid,'%s',1);
%         	noise_bqf_single(j)=str2double(A);
	end
   
    end
    fclose(fid);
end	
