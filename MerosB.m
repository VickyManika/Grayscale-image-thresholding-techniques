clc; clear; close all; format compact;

% Ορισμός ονόματος αρχείου εικόνας
Filename='sonet.jpg';
% Διάβασμα εικόνας
I=imread(Filename);

% Δύο πρώτες διαστάσεις της εικόνας -> Row:Γραμμές , Cols:Στήλες
[Row,Cols,~]=size(I);

% Eμφάνιση αρχικής εικόνας στην πρώτη γραμμή και πρώτη στήλη
subplot(2,2,1) , imshow(I) , title 'Original image'

% Μέγεθος του παραθύρου R
R=[63 63]

% Σταθερά C
C=15

tic % Aρχή χρονομέτρησης της διαδικασίας
% Υπολογισμός του πίνακα του κατωφλιού=t1 με την μέση τιμή των pixel του παραθύρου
t1=uint8(colfilt(I,R,'sliding',@mean) - C);

% Μετατροπή σε δυαδική εικόνα με βαση το t1
% Για κάθε γραμμη της αρχικής εικόνας
for i=1:Row
    % Για κάθε στήλη της αρχικής εικόνας
    for j=1:Cols
        % Oρίζω ως pixel τα pixel της αρχικής εικόνας
        pixel=I(i,j);
     % Αν το pixel ειναι μικρότερο του κατωφλιόυ=τ1    
    if pixel<t1(i,j)
        % Τοτε θέσε το pixel με 0
        pixel=0;
     % Αλλιως θέσε το pixel με 1    
    else
        pixel=1;
    end
     % Aποθήκευση των καινούριων τιμών των pixel στην δυαδική εικόνα
    BW_IMAGE(i,j)=pixel;
    % Tέλος for
    end
 % Τέλος for     
end

% Εμφάνιση της δυαδικής εικόνας στην πρώτη γραμμη και δεύτερη στήλη
subplot(2,2,2) , imshow(BW_IMAGE) , title 'Binary image-MEAN'
toc % Tέλος χρονομέτησης διαδικασίας

tic % Aρχή χρονομέτρησης της διδικασίας
% Υπολογισμός του πίνακα του κατωφλιού=t2 με την διάμεση τιμή των pixel του παραθύρου
t2=colfilt(I,R,'sliding',@median) - C;
% Μετατροπή σε δυαδική εικόνα με βάση το t2 όπως προηγούμενα   
for i=1:Row
    for j=1:Cols
        pixel=I(i,j);
    if pixel<t2(i,j)
        pixel=0;
    else
        pixel=1;
    end
    BW_IMAGE(i,j)=pixel;
    end
end

% Εμαφανιση της δυαδικής εικόνας στην δεύτερη γραμμη και πρώτη στήλη
subplot(2,2,3) , imshow(BW_IMAGE) , title 'Binary image-MEDIAN'
toc  % Tέλος χρονομέτησης διαδικασίας

tic % Aρχή χρονομέτρησης της διδικασίας
% Υπολογισμός του πίνακα του κατωφλιού=t3 με την ενδιάμεση graylevel τιμή των pixel του παραθύρου
t3=colfilt(I,R,'sliding',@interGL) - C;

% Μετατροπή σε δυαδική εικόνα με βάση το t3 όπως προηγούμενα   
for i=1:Row
    for j=1:Cols
        pixel=I(i,j);
    if pixel<t3(i,j)
        pixel=0;
    else
        pixel=1;
    end
    BW_IMAGE(i,j)=pixel;
    end
end
% Εμαφανιση της δυαδικής εικόνας στην δεύτερη γραμμη και δεύτερη στήλη
subplot(2,2,4) , imshow(BW_IMAGE) , title 'Binary image-INTERGL'
toc % Tέλος χρονομέτησης διαδικασίας

% H συνάρτηση που υπολογίζει την ενδιάμεση graylevel τιμή των pixel του παραθύρου
function y=interGL(x)
y= (min(x)+max(x))/2;
end
