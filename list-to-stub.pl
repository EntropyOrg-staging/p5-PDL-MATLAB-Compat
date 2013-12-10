#!/usr/bin/env perl

use strict;
use warnings;

use File::Slurp;
use IPC::Open2;
use YAML::XS qw/DumpFile/;
my @list = split ' ', read_file(\*DATA);

open2( my $matlab_read, my $matlab_write,  'matlab -nodesktop -nodisplay -nojvm -nosplash 2>&1' );

my $data = {};
for my $cmd (@list) {
	print "getting help for $cmd\n";
	print $matlab_write "help $cmd\n";
	print "done\n";
}
print $matlab_write "exit\n";
my $lines = read_file($matlab_read);
my @help = split ">>", $lines;
use DDP; p @help;

shift @help; pop @help;

@$data{ @list } = @help;
use DDP; p $data;


__DATA__
abs           cos           filter     imagesc     magic        repmat       subplot 
acos          cov           find       imcrop      mat2gray     reshape      sum 
addpath       cumsum        findobj    imfilter    max          rgb2gray     svd 
all           deblank       fitfun     imread      mean         rmpath       switch 
alpha         deconvblind   fix        imresize    mean2        round        tan 
and           deconvwnr     fliplr     imrotate    median       save         tanh 
any           delete        flipud     imshow      menu         saveas       text 
aryule        det           floor      imwrite     mesh         set          textscan 
asin          diag          flops      inline      meshgrid     setdiff      textwrap 
atan          dir           fopen      input       min          sign         title 
atan2         disp          fplot      inputname   mod          sin          trace 
axes          double        fprintf    int2str     nargchk      single       tril 
axis          downsample    fread      interp2     ndgrid       size         truesize 
bar           drawnow       fscanf     inv         nlfilter     sort         uicontrol 
blanks        edge          fseek      iradon      norm         sortrows     uigetfile 
blkproc       editpath      fspecial   isa         normxcorr2   soundsc      uimenu 
box           eig           full       ischar      num2str      sparse       uint32 
buffer        eigs          function   isempty     ones         spdiags      uint8 
cat           elseif        fwrite     isequal     open         speye        unique 
ceil          end           gallery    isfield     ordfilt2     sprintf      var 
cell          entropy       get        ishandle    patch        sqrt         varargin 
cell2mat      error         getrect    isnumeric   path         squeeze      version 
cell2struct   errordlg      ginput     isreal      pause        sscanf       view 
char          eval          gplot      isstr       permute      start        warning 
chol          exist         gradient   isstruct    pinv         std          watchoff 
cholupdate    exp           gray       kron        plot         std2         while 
circshift     eye           grid       legend      primes       stem         whitebg 
clabel        factor        griddata   length      printdlg     str2func     whos 
class         fclose        guidata    line        prod         str2num      window 
clear         fcnchk        hanning    linspace    questdlg     strcat       xlabel 
close         feval         helpdlg    load        radon        strcmp       xor 
colfilt       fft           hist       log         rand         strcmpi      ylabel 
colormap      fft2          histc      log10       randn        stretchlim   zeros 
colperm       fftshift      hold       log2        randperm     strncmp 
conj          fieldnames    ifft       logical     rank         strrep 
contour       figure        imadjust   lower       real         strtok 
conv2         fill          image      ls          rem          struct
