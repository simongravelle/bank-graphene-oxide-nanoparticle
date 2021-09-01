%clear all
%close all
%beep off

% read the datafile
fid = fopen('./GO.data');
tline = fgetl(fid);
tline = fgetl(fid);
tline([end-5:end])=[];
Natoms=str2num(tline);

tline = fgetl(fid);
tline([end-5:end])=[];
Nbonds=str2num(tline);

tline = fgetl(fid);
tline([end-6:end])=[];
Nangles=str2num(tline);

tline = fgetl(fid);
tline([end-9:end])=[];
Ndihedrals=str2num(tline);

tline = fgetl(fid);
tline([end-9:end])=[];
Nimpropers =str2num(tline);

tline = fgetl(fid);
tline = fgetl(fid);
tline([end-10:end])=[];
Tatoms=str2num(tline);

tline = fgetl(fid);
tline([end-10:end])=[];
Tbonds=str2num(tline);

tline = fgetl(fid);
tline([end-11:end])=[];	
Tangles=str2num(tline);

tline = fgetl(fid);
tline([end-14:end])=[];
Tdihedrals=str2num(tline);

tline = fgetl(fid);
tline([end-14:end])=[];
Timpropers=str2num(tline);

tline = fgetl(fid);

tline = fgetl(fid);
tline([end-7:end])=[];
xcoor=str2num(tline); Lx=xcoor(2)-xcoor(1);
tline = fgetl(fid);
tline([end-7:end])=[];
ycoor=str2num(tline); Ly=ycoor(2)-ycoor(1);
tline = fgetl(fid);
tline([end-7:end])=[];
zcoor=str2num(tline); Lz=zcoor(2)-zcoor(1);

tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
%
run=1;
ii=0;
while run==1
	ii=ii+1;
	tline = fgetl(fid);
	line0=str2num(tline);
	jj=line0(1);
	if ii==jj
		MassCoeff(ii,:)=line0;
	else
		run=0;
	end
end

tline = fgetl(fid);

tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
%
run=1;
ii=0;
while run==1
	ii=ii+1;
	tline = fgetl(fid);
	line0=str2num(tline);
	jj=line0(1);
	if ii==jj
		PairCoeff(ii,:)=line0;
	else
		run=0;
	end
end

tline = fgetl(fid);

tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
%
for ii=1:Tbonds
	tline = fgetl(fid);
	line0=str2num(tline);
	TypeBond(ii,:)=line0;
end
tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
%
for ii=1:Tangles
	tline = fgetl(fid);
	line0=str2num(tline);
	TypeAngle(ii,:)=line0;
end
tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
%
for ii=1:Tdihedrals
	tline = fgetl(fid);
	line0=str2num(tline);
	TypeDihedrals(ii,:)=line0;
end
tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
%
for ii=1:Timpropers
	tline = fgetl(fid);
	line0=str2num(tline);
	TypeImpropers(ii,:)=line0;
end

%
tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
%
for ii=1:Natoms
	tline = fgetl(fid);
	%tline([end-8:end])=[];
	Positions(ii,:)=str2num(tline);
end
%
tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
%
for ii=1:Nbonds
	tline = fgetl(fid);
	Bonds(ii,:)=str2num(tline);
end
%
tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
%
for ii=1:Nangles
	tline = fgetl(fid);
	Angles(ii,:)=str2num(tline);
end
%
tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
%
for ii=1:Ndihedrals
	tline = fgetl(fid);
	Dihedrals(ii,:)=str2num(tline);
end
%
tline = fgetl(fid);
tline = fgetl(fid);
tline = fgetl(fid);
%
for ii=1:Nimpropers
	tline = fgetl(fid);
	Impropers(ii,:)=str2num(tline);
end




fid2 = fopen('Graphitics/Positions.dat','wt');
for ii=1:length(Positions(:,1))
	for jj=1:7
		if jj==1
			fprintf(fid2, num2str(Positions(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==2
			fprintf(fid2, num2str(Positions(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==3
			fprintf(fid2, num2str(Positions(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==4
			fprintf(fid2, num2str(Positions(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==5
			fprintf(fid2, num2str(Positions(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==6
			fprintf(fid2, num2str(Positions(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==7
			fprintf(fid2, num2str(Positions(ii,jj)));
			fprintf(fid2, '	');
		end
	end
	fprintf(fid2, '\n');
end
fclose(fid2);

fid2 = fopen('Graphitics/Bonds.dat','wt');
for ii=1:length(Bonds(:,1))
	for jj=1:7
		if jj==1
			fprintf(fid2, num2str(ii));
			fprintf(fid2, '	');
		elseif jj==2
			fprintf(fid2, num2str(Bonds(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==3
			fprintf(fid2, num2str(Bonds(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==4
			fprintf(fid2, num2str(Bonds(ii,jj)));
			fprintf(fid2, '	');
		end
	end
	fprintf(fid2, '\n');
end
fclose(fid2);

fid2 = fopen('Graphitics/Angles.dat','wt');
for ii=1:length(Angles(:,1))
	for jj=1:7
		if jj==1
			fprintf(fid2, num2str(ii));
			fprintf(fid2, '	');
		elseif jj==2
			fprintf(fid2, num2str(Angles(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==3
			fprintf(fid2, num2str(Angles(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==4
			fprintf(fid2, num2str(Angles(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==5
			fprintf(fid2, num2str(Angles(ii,jj)));
			fprintf(fid2, '	');
		end
	end
	fprintf(fid2, '\n');
end
fclose(fid2);

fid2 = fopen('Graphitics/Dihedrals.dat','wt');
for ii=1:length(Dihedrals(:,1))
	for jj=1:7
		if jj==1
			fprintf(fid2, num2str(ii));
			fprintf(fid2, '	');
		elseif jj==2
			fprintf(fid2, num2str(Dihedrals(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==3
			fprintf(fid2, num2str(Dihedrals(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==4
			fprintf(fid2, num2str(Dihedrals(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==5
			fprintf(fid2, num2str(Dihedrals(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==6
			fprintf(fid2, num2str(Dihedrals(ii,jj)));
			fprintf(fid2, '	');
		end
	end
	fprintf(fid2, '\n');
end
fclose(fid2);

fid2 = fopen('Graphitics/Impropers.dat','wt');
for ii=1:length(Impropers(:,1))
	for jj=1:7
		if jj==1
			fprintf(fid2, num2str(ii));
			fprintf(fid2, '	');
		elseif jj==2
			fprintf(fid2, num2str(Impropers(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==3
			fprintf(fid2, num2str(Impropers(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==4
			fprintf(fid2, num2str(Impropers(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==5
			fprintf(fid2, num2str(Impropers(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==6
			fprintf(fid2, num2str(Impropers(ii,jj)));
			fprintf(fid2, '	');
		end
	end
	fprintf(fid2, '\n');
end
fclose(fid2);

fid2 = fopen('Graphitics/MassCoeff.dat','wt');
for ii=1:length(MassCoeff(:,1))
	for jj=1:2
		if jj==1
			fprintf(fid2, num2str(MassCoeff(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==2
			fprintf(fid2, num2str(MassCoeff(ii,jj)));
			fprintf(fid2, '	');
		end
	end
	fprintf(fid2, '\n');
end
fclose(fid2);

fid2 = fopen('Graphitics/PairCoeffs.dat','wt');
for ii=1:length(PairCoeff(:,1))
	for jj=1:3
		if jj==1
			fprintf(fid2, num2str(PairCoeff(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==2
			fprintf(fid2, num2str(PairCoeff(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==3
			fprintf(fid2, num2str(PairCoeff(ii,jj)));
			fprintf(fid2, '	');
		end
	end
	fprintf(fid2, '\n');
end
fclose(fid2);

fid2 = fopen('Graphitics/TypeBond.dat','wt');
for ii=1:length(TypeBond(:,1))
	for jj=1:3
		if jj==1
			fprintf(fid2, num2str(TypeBond(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==2
			fprintf(fid2, num2str(TypeBond(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==3
			fprintf(fid2, num2str(TypeBond(ii,jj)));
			fprintf(fid2, '	');
		end
	end
	fprintf(fid2, '\n');
end
fclose(fid2);

fid2 = fopen('Graphitics/TypeAngle.dat','wt');
for ii=1:length(TypeAngle(:,1))
	for jj=1:3
		if jj==1
			fprintf(fid2, num2str(TypeAngle(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==2
			fprintf(fid2, num2str(TypeAngle(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==3
			fprintf(fid2, num2str(TypeAngle(ii,jj)));
			fprintf(fid2, '	');
		end
	end
	fprintf(fid2, '\n');
end
fclose(fid2);

fid2 = fopen('Graphitics/TypeDihedrals.dat','wt');
for ii=1:length(TypeDihedrals(:,1))
	for jj=1:5
		if jj==1
			fprintf(fid2, num2str(TypeDihedrals(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==2
			fprintf(fid2, num2str(TypeDihedrals(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==3
			fprintf(fid2, num2str(TypeDihedrals(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==4
			fprintf(fid2, num2str(TypeDihedrals(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==5
			fprintf(fid2, num2str(TypeDihedrals(ii,jj)));
			fprintf(fid2, '	');
		end
	end
	fprintf(fid2, '\n');
end
fclose(fid2);

fid2 = fopen('Graphitics/TypeImpropers.dat','wt');
for ii=1:length(TypeImpropers(:,1))
	for jj=1:3
		if jj==1
			fprintf(fid2, num2str(TypeImpropers(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==2
			fprintf(fid2, num2str(TypeImpropers(ii,jj)));
			fprintf(fid2, '	');
		elseif jj==3
			fprintf(fid2, num2str(TypeImpropers(ii,jj)));
			fprintf(fid2, '	');
		end
	end
	fprintf(fid2, '\n');
end
fclose(fid2);

