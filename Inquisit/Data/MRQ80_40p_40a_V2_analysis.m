subject = 0;

for i = 1:size(M)
    
    if M(1,i) == M(1,i+1)
        subject = subject;
    else subject = subject +1
    end
    
end