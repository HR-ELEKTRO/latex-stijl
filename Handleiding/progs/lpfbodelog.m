hs = tf(1000*2*pi, [1 1000*2*pi]);
opts = bodeoptions;
opts.Title.String = '';
opts.FreqUnits = 'Hz';
opts.FreqScale = 'log';
opts.grid = 'on';
h = bodeplot(hs, opts);
L = findobj(gcf, 'type' , 'line');
set(L, 'Color', [204/255 0 51/255]);
%generate pdf file for use in LaTeX
file = '../figs/lpfbodelog';
print(gcf,'-dpdf', file);
system(sprintf('pdfcrop %s.pdf %s.pdf', file, file));