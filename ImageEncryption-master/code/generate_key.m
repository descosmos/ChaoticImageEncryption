function private_key = generate_key(img)
%{
  generate_key():  The function is used to produce key depending on img.
  When the control_para in [2.5, 3.2] approximately, the system state is in chaotic state.
%} 

    %{ generate_logistic_key(): The function is used to produce key by using logistic chaotic mapping.%}
    function logistic_key = generate_logistic_key(img)
        %control_para = mod(rand(1)*17, 4);
        control_para = 2.3;
        [M,N] = size(img);
        N = 4*N;
        logistic_key = zeros(M,N);
        logistic_key(1) = 0.98;
        for i = 2:M*N
            logistic_key(i) = control_para*logistic_key(i-1)*(1-logistic_key(i-1)^2);
        end
        for i = 1:M*N
            logistic_key(i) = mod(round(logistic_key(i)*23399), 256);
        end
    end

    %{ generate_sine_key(): The function is used to produce key by using sine chaotic mapping.%}
    function sine_key = generate_sine_key(img)
        [M,N] = size(img);
        N = 4*N;
        sine_key = zeros(M,N);
        sine_key(1) = 0.98;
        control_parameter = 1000;
        
        for i = 2:M*N
            sine_key(i) = control_parameter*sin(pi*sine_key(i-1))/4;
        end
        for i = 1:M*N
            sine_key(i) = mod(round(sine_key(i)*23399), 256);
        end
    end

    %{ generate_llss_key(): The function is used to produce key by using LLSS chaotic mapping.%}
    function llss_key = generate_llss_key(img)
        [M,N] = size(img);
        N = 4*N;
        %llss_key = zeros(M,N);
        logistic_key1 = generate_logistic_key(img);
        logistic_key2 = generate_logistic_key(img);
        sine_key = generate_sine_key(img);
        llss_key = bitxor(logistic_key1, logistic_key2);
        llss_key = bitxor(llss_key, sine_key);
    end
%{
 By using hypodispersion and function randi(), 
the security of algorithm is enhansive. 
%}
[M,N] = size(img);
rand_matrix = uint8(randi(255, [M,4*N]));

logistic_private_key = generate_logistic_key(img);
logistic_private_key = uint8(logistic_private_key);
logistic_private_key = bitxor(rand_matrix, logistic_private_key);
%sine_private_key = generate_sine_key(img);
%sine_private_key = uint8(sine_private_key);
%sine_private_key = bitxor(rand_matrix, sine_private_key);
%llss_private_key = generate_key(img);
%llss_private_key = bitxor(rand_matrix, llss_private_key);

%private_key = llss_private_key;
private_key = logistic_private_key;
%private_key = sine_private_key;

% illustrate the private key image.
%imshow(private_key, [])
end