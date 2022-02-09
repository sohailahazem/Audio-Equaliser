filename = input('Enter file name: ','s');
file_name = [filename '.wav'];
[y , fs] = audioread(file_name);
if(fs < 32000)
    [p,q] = rat(36000/fs);  %provides both the numerator and denominator of the rational factor of the resample function
    y = resample(y,p,q);    % desiredfs = p/q * originalfs
    fs = 36000;             
end
%inputting the gains of each filter
g1 = db2mag(input('Enter 1st gain (dB): '));
g2 = db2mag(input('Enter 2nd gain (dB): '));
g3 = db2mag(input('Enter 3rd gain (dB): '));
g4 = db2mag(input('Enter 4th gain (dB): '));
g5 = db2mag(input('Enter 5th gain (dB): '));
g6 = db2mag(input('Enter 6th gain (dB): '));
g7 = db2mag(input('Enter 7th gain (dB): '));
g8 = db2mag(input('Enter 8th gain (dB): '));
g9 = db2mag(input('Enter 9th gain (dB): '));

type_of_filter = input('Enter type of filter (FIR / IIR): ','s');
sample_rate = input('Enter the output sample rate: '); 

fprintf('-----------------------------------------------------------------------------------------------------\n')
fprintf('Magnitude of Filter Gains:\n')
fprintf('Gain of [0 - 170] Hz filter = %.2f\n', g1);
fprintf('Gain of [170 - 310] Hz filter = %.2f\n', g2);
fprintf('Gain of [310 - 600] Hz filter = %.2f\n', g3);
fprintf('Gain of [600 - 1k] Hz filter = %.2f\n', g4);
fprintf('Gain of [1k - 3k] Hz filter = %.2f\n', g5);
fprintf('Gain of [3k - 6k] Hz filter = %.2f\n', g6);
fprintf('Gain of [6k - 12k] Hz filter = %.2f\n', g7);
fprintf('Gain of [12k - 14k] Hz filter = %.2f\n', g8);
fprintf('Gain of [14k - 16k] Hz filter = %.2f\n', g9);


if strcmpi(type_of_filter,'FIR')  %FIR Filters
    order = 60;  %order
    fcn = fs/2;  
    fprintf('Order = %i\n',order)
    %Normalized cut off frequencies   
    wc1 = 170/fcn;
    wc2 = 310/fcn;
    wc3 = 600/fcn;
    wc4 = 1000/fcn;
    wc5 = 3000/fcn;
    wc6 = 6000/fcn;
    wc7 = 12000/fcn;
    wc8 = 14000/fcn;
    wc9 = 16000/fcn;
    
    %(1) filters
    h1 = fir1(order , wc1,'low');           %[0-170]Hz
    h2 = fir1(order ,[wc1 wc2],'bandpass'); %[170-310]Hz
    h3 = fir1(order ,[wc2 wc3],'bandpass'); %[310-600]Hz
    h4 = fir1(order ,[wc3 wc4],'bandpass'); %[600-1000]Hz
    h5 = fir1(order ,[wc4 wc5],'bandpass'); %[1000-3000]Hz
    h6 = fir1(order ,[wc5 wc6],'bandpass'); %[3000-6000]Hz
    h7 = fir1(order ,[wc6 wc7],'bandpass'); %[6000-12000]Hz
    h8 = fir1(order ,[wc7 wc8],'bandpass'); %[12000-14000]Hz
    h9 = fir1(order ,[wc8 wc9],'bandpass'); %[14000-16000]Hz
%==========================================================================
%(2) Analyzing filters
    % (0 - 170Hz) filter
    figure('Name','Low pass Filter [0 - 170Hz]','NumberTitle','off');
    [H, W] = freqz(h1,1,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(h1,1);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(h1,1);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(h1,1);
    title('Pole-Zero Map')
    grid;
 %-------------------------------------------------------------------------      
    % (170 - 310Hz) filter
    figure('Name','Band pass Filter [170 - 310Hz]','NumberTitle','off');
    [H, W] = freqz(h2,1,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(h2,1);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(h2,1);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(h2,1);
    title('Pole-Zero Map')
    grid;
%--------------------------------------------------------------------------
    % (310 - 600Hz) filter
    figure('Name','Band pass Filter [310 - 600Hz]','NumberTitle','off');
    [H, W] = freqz(h3,1,fs);
    
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(h3,1);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(h3,1);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(h3,1);
    title('Pole-Zero Map')
    grid;
%--------------------------------------------------------------------------     
    % (600 - 1KHz) filter
    figure('Name','Band pass Filter [600 - 1KHz]','NumberTitle','off');
    [H, W] = freqz(h4,1,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(h4,1);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(h4,1);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(h4,1);
    title('Pole-Zero Map')
    grid;
%-------------------------------------------------------------------------- 
     % (1K - 3KHz) filter
    figure('Name','Band pass Filter [1K - 3KHz]','NumberTitle','off');
    [H, W] = freqz(h5,1,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(h5,1);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(h5,1);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(h5,1);
    title('Pole-Zero Map')
    grid;
%--------------------------------------------------------------------------  
     % (3K - 6KHz) filter
    figure('Name','Band pass Filter [3K - 6KHz]','NumberTitle','off');
    [H, W] = freqz(h6,1,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(h6,1);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(h6,1);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(h6,1);
    title('Pole-Zero Map')
    grid;
 %-------------------------------------------------------------------------  
     % (6K - 12KHz) filter
    figure('Name','Band pass Filter [6K - 12KHz]','NumberTitle','off');
    [H, W] = freqz(h7,1,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(h7,1);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(h7,1);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(h7,1);
    title('Pole-Zero Map')
    grid;
%--------------------------------------------------------------------------  
     % (12K - 14KHz) filter
    figure('Name','Band pass Filter [12K - 14KHz]','NumberTitle','off');
    [H, W] = freqz(h8,1,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(h8,1);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(h8,1);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(h8,1);
    title('Pole-Zero Map')
    grid;
%--------------------------------------------------------------------------   
     % (14K - 16KHz) filter
    figure('Name','Band pass Filter [14K - 16KHz]','NumberTitle','off');
    [H, W] = freqz(h9,1,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(h9,1);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(h9,1);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(h9,1);
    title('Pole-Zero Map')
    grid;
%==========================================================================
  % (3) Original Filtered Signals
    f1 = filter(h1,1,y);
    f2 = filter(h2,1,y);
    f3 = filter(h3,1,y);
    f4 = filter(h4,1,y);
    f5 = filter(h5,1,y);
    f6 = filter(h6,1,y);
    f7 = filter(h7,1,y);
    f8 = filter(h8,1,y);
    f9 = filter(h9,1,y);
    
%==========================================================================
  %(4) Draw output in Time and Frequency Domains
  
    % (0 - 170Hz) filter
    figure('Name','Filtered Signal [0-170]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f1);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f1))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (170 - 310Hz) filter
    figure('Name','Filtered Signal [170-310]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f2);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f2))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------   
    % (310 - 600Hz) filter
    figure('Name','Filtered Signal [310-600]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f3);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f3))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (600 - 1KHz) filter
    figure('Name','Filtered Signal [600-1K]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f4);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f4))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (1K - 3KHz) filter
    figure('Name','Filtered Signal [1K-3K]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f5);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f5))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (3K - 6KHz) filter
    figure('Name','Filtered Signal [3K-6K]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f6);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f6))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (6K - 12KHz) filter
    figure('Name','Filtered Signal [6K-12K]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f7);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f7))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (12K - 14KHz) filter
    figure('Name','Filtered Signal [12K-14K]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f8);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f8))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (14K - 16KHz) filter
    figure('Name','Filtered Signal [14K-16K]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f9);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f9))));
    title('Frequency Domain');
    grid;          
%==========================================================================    
 % (5)Amplified filtered signals:
    famp1 = g1*filter(h1,1,y);
    famp2 = g2*filter(h2,1,y);
    famp3 = g3*filter(h3,1,y);
    famp4 = g4*filter(h4,1,y);
    famp5 = g5*filter(h5,1,y);
    famp6 = g6*filter(h6,1,y);
    famp7 = g7*filter(h7,1,y);
    famp8 = g8*filter(h8,1,y);
    famp9 = g9*filter(h9,1,y);
    
 %=========================================================================  
  % (6) Composite signal:
  composite_signal = famp1+famp2+famp3+famp4+famp5+famp6+famp7+famp8+famp9;
  
 %=========================================================================
  % (7) Draw Composite Signal Vs Original signal in Time and Frequency domain:
  
   figure('Name','Original signal vs Composite Signal','NumberTitle','off')
        subplot(2,2,1);
        plot(y)
        title('Original Signal [Time Domain]');
        grid;
        
        subplot(2,2,2);
        plot(abs(fftshift(fft(y))))
        title('Original Signal [Frequency Domain] ');
        grid;

        subplot(2,2,3);
        plot(composite_signal)
        title('Composite Amplified Signal [Time Domain]');
        grid;

        subplot(2,2,4);
        plot(abs(fftshift(fft(composite_signal))))
        title('Composite Amplified Signal [Frequency Domain]');
        grid;
        
%=========================================================================  
  % (8) Playing the output wave signal using Output sample rate taken from user:
   
  [n,d] = rat(sample_rate/fs);                             %provides both the numerator and denominator of the rational factor of the resample function
  resampled_composite = resample(composite_signal,n,d);    % desiredfs = n/d * originalfs
  sound(resampled_composite,sample_rate);                  
  audiowrite('new.wav',resampled_composite,sample_rate);
%==========================================================================   
  % Output signal if doubling sample rate or decreasing the sample rate by half: 
  
    half_composite = resample(resampled_composite,1,2);
    audiowrite('half.wav',half_composite,sample_rate/2);
    double_composite = resample(resampled_composite,2,1);
    audiowrite('double.wav',double_composite,sample_rate*2);
    
    figure('Name','Doubled output sample rate vs Decreasing Sample rate by half ','NumberTitle','off');
    subplot(2,2,1);
        plot(half_composite)
        title('Decreasing by half [Time Domain]');
        grid;
        
        subplot(2,2,2);
        plot(abs(fftshift(fft(half_composite))))
        title('Decreasing by half [Frequency Domain] ');
        grid;

        subplot(2,2,3);
        plot(double_composite)
        title('Doubling [Time Domain]');
        grid;

        subplot(2,2,4);
        plot(abs(fftshift(fft(double_composite))))
        title('Doubling [Frequency Domain]');
        grid;
     
%========================================================================== 
elseif strcmpi(type_of_filter,'IIR')    %IIR Filters
    
    %Normalized cut off frequencies 
    order = 4; %order 
    fprintf('Order = %i\n',order)
    fcn = fs/2;
    wc1 = 170/fcn;
    wc2 = 310/fcn;
    wc3 = 600/fcn;
    wc4 = 1000/fcn;
    wc5 = 3000/fcn;
    wc6 = 6000/fcn;
    wc7 = 12000/fcn;
    wc8 = 14000/fcn;
    wc9 = 16000/fcn;
    
    %(1) filters
    [n1,d1] = butter(order ,wc1);       %[0-170]Hz
    [n2,d2] = butter(order ,[wc1 wc2]); %[170-310]Hz
    [n3,d3] = butter(order ,[wc2 wc3]); %[310-600]Hz
    [n4,d4] = butter(order ,[wc3 wc4]); %[600-1000]Hz
    [n5,d5] = butter(order ,[wc4 wc5]); %[1000-3000]Hz
    [n6,d6] = butter(order ,[wc5 wc6]); %[3000-6000]Hz
    [n7,d7] = butter(order ,[wc6 wc7]); %[6000-12000]Hz
    [n8,d8] = butter(order ,[wc7 wc8]); %[12000-14000]Hz
    [n9,d9] = butter(order ,[wc8 wc9]); %[14000-16000]Hz
%==========================================================================
    %(2) Analyzing filters
    % (0 - 170Hz) filter
    figure('Name','Low pass Filter [0 - 170Hz]','NumberTitle','off');
    [H, W] = freqz(n1,d1,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(n1,d1);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(n1,d1);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(n1,d1);
    title('Pole-Zero Map')
    grid;
 %-------------------------------------------------------------------------      
    % (170 - 310Hz) filter
    figure('Name','Band pass Filter [170 - 310Hz]','NumberTitle','off');
    [H, W] = freqz(n2,d2,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(n2,d2);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(n2,d2);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(n2,d2);
    title('Pole-Zero Map')
    grid;
%--------------------------------------------------------------------------
    % (310 - 600Hz) filter
    figure('Name','Band pass Filter [310 - 600Hz]','NumberTitle','off');
    [H, W] = freqz(n3,d3,fs);
    
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(n3,d3);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(n3,d3);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(n3,d3);
    title('Pole-Zero Map')
    grid;
%--------------------------------------------------------------------------     
    % (600 - 1KHz) filter
    figure('Name','Band pass Filter [600 - 1KHz]','NumberTitle','off');
    [H, W] = freqz(n4,d4,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(n4,d4);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(n4,d4);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(n4,d4);
    title('Pole-Zero Map')
    grid;
%-------------------------------------------------------------------------- 
     % (1K - 3KHz) filter
    figure('Name','Band pass Filter [1K - 3KHz]','NumberTitle','off');
    [H, W] = freqz(n5,d5,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(n5,d5);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(n5,d5);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(n5,d5);
    title('Pole-Zero Map')
    grid;
%--------------------------------------------------------------------------  
     % (3K - 6KHz) filter
    figure('Name','Band pass Filter [3K - 6KHz]','NumberTitle','off');
    [H, W] = freqz(n6,d6,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(n6,d6);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(n6,d6);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(n6,d6);
    title('Pole-Zero Map')
    grid;
 %-------------------------------------------------------------------------  
     % (6K - 12KHz) filter
    figure('Name','Band pass Filter [6K - 12KHz]','NumberTitle','off');
    [H, W] = freqz(n7,d7,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(n7,d7);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(n7,d7);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(n7,d7);
    title('Pole-Zero Map')
    grid;
%--------------------------------------------------------------------------  
     % (12K - 14KHz) filter
    figure('Name','Band pass Filter [12K - 14KHz]','NumberTitle','off');
    [H, W] = freqz(n8,d8,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(n8,d8);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(n8,d8);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(n8,d8);
    title('Pole-Zero Map')
    grid;
%--------------------------------------------------------------------------   
     % (14K - 16KHz) filter
    figure('Name','Band pass Filter [14K - 16KHz]','NumberTitle','off');
    [H, W] = freqz(n9,d9,fs);
    subplot(3,2,1)
    plot(W,abs(H))
    title('Magnitude response');
    grid;
    
    subplot(3,2,2)
    plot(W,angle(H))
    title('Phase response');
    grid;
    
    subplot(3,2,3)
    impz(n9,d9);
    title('Impulse Response');
    grid;
    
    subplot(3,2,4)
    stepz(n9,d9);
    title('Step Response');
    grid;
    
    subplot(3,2,[5,6])
    zplane(n9,d9);
    title('Pole-Zero Map')
    grid;
%==========================================================================
     % (3) Original Filtered Signals
    f1 = filter(n1,d1,y);
    f2 = filter(n2,d2,y);
    f3 = filter(n3,d3,y);
    f4 = filter(n4,d4,y);
    f5 = filter(n5,d5,y);
    f6 = filter(n6,d6,y);
    f7 = filter(n7,d7,y);
    f8 = filter(n8,d8,y);
    f9 = filter(n9,d9,y);
    
%==========================================================================
   %(4) Draw output in Time and Frequency Domains
   
    % (0 - 170Hz) filter
    figure('Name','Filtered Signal [0-170]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f1);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f1))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (170 - 310Hz) filter
    figure('Name','Filtered Signal [170-310]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f2);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f2))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------   
    % (310 - 600Hz) filter
    figure('Name','Filtered Signal [310-600]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f3);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f3))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (600 - 1KHz) filter
    figure('Name','Filtered Signal [600-1K]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f4);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f4))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (1K - 3KHz) filter
    figure('Name','Filtered Signal [1K-3K]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f5);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f5))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (3K - 6KHz) filter
    figure('Name','Filtered Signal [3K-6K]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f6);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f6))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (6K - 12KHz) filter
    figure('Name','Filtered Signal [6K-12K]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f7);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f7))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (12K - 14KHz) filter
    figure('Name','Filtered Signal [12K-14K]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f8);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f8))));
    title('Frequency Domain');
    grid;
%--------------------------------------------------------------------------    
    % (14K - 16KHz) filter
    figure('Name','Filtered Signal [14K-16K]Hz','NumberTitle','off');
    subplot(2,2,[1,2])
    plot(f9);
    title('Time Domain');
    grid;
    subplot(2,2,[3,4]);
    plot(abs(fftshift(fft(f9))));
    title('Frequency Domain');
    grid;          
%==========================================================================    
 % (5)Amplified filtered signals:
    famp1 = g1*filter(n1,d1,y);
    famp2 = g2*filter(n2,d2,y);
    famp3 = g3*filter(n3,d3,y);
    famp4 = g4*filter(n4,d4,y);
    famp5 = g5*filter(n5,d5,y);
    famp6 = g6*filter(n6,d6,y);
    famp7 = g7*filter(n7,d7,y);
    famp8 = g8*filter(n8,d8,y);
    famp9 = g9*filter(n9,d9,y);
    
 %=========================================================================
  % (6) Composite signal:
  composite_signal = famp1+famp2+famp3+famp4+famp5+famp6+famp7+famp8+famp9;
  
 %=========================================================================
  % (7) Draw Composite Signal Vs original signal in Time and Frequency domain:
  
   figure('Name','Original signal vs Composite Signal','NumberTitle','off')
        subplot(2,2,1);
        plot(y)
        title('Original Signal [Time Domain]');
        grid;
        
        subplot(2,2,2);
        plot(abs(fftshift(fft(y))))
        title('Original Signal [Frequency Domain] ');
        grid;

        subplot(2,2,3);
        plot(composite_signal)
        title('Composite Amplified Signal [Time Domain]');
        grid;

        subplot(2,2,4);
        plot(abs(fftshift(fft(composite_signal))))
        title('Composite Amplified Signal [Frequency Domain]');
        grid;
        
%=========================================================================  
  % (8) Playing the output wave signal using Output sample rate taken from user:
  [n,d] = rat(sample_rate/fs);                           %provides both the numerator and denominator of the rational factor of the resample function
  resampled_composite = resample(composite_signal,n,d);  % desiredfs = n/d * originalfs 
  sound(resampled_composite,sample_rate);                 
  audiowrite('new.wav',resampled_composite,sample_rate);
%==========================================================================   
  % Output signal if doubling sample rate or decreasing the sample rate by half: 
  
    half_composite = resample(resampled_composite,1,2);
    audiowrite('half.wav',half_composite,sample_rate/2);
    double_composite = resample(resampled_composite,2,1);
    audiowrite('double.wav',double_composite,sample_rate*2);
    
    figure('Name','Doubled output sample rate vs Decreasing Sample rate by half ','NumberTitle','off');
    subplot(2,2,1);
        plot(half_composite)
        title('Decreasing by half [Time Domain]');
        grid;
        
        subplot(2,2,2);
        plot(abs(fftshift(fft(half_composite))))
        title('Decreasing by half [Frequency Domain] ');
        grid;

        subplot(2,2,3);
        plot(double_composite)
        title('Doubling [Time Domain]');
        grid;

        subplot(2,2,4);
        plot(abs(fftshift(fft(double_composite))))
        title('Doubling [Frequency Domain]');
        grid;
    
    else 
       fprintf('Wrong entry.Try again\n')
       
        
 end              