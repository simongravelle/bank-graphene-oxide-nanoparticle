clear all
close all
beep off
rng('shuffle');

nMax=0;
while nMax<50

	cpt=0;
	retry=1;
	while retry==1

		clearvars -except cpt faillure retry nMax desOH rOH ref
		
		rOH=0.5;
		rOC=0;
		
		%desOH=29+randi(10); 
		% desOH=0 for rOC=0, desOH=16+randi(3) for rOC=0.16, desOH=6 for rOC=0.05
		
		% select N
		%Ncal=load('calibratedN.txt');
		%int=Ncal(Ncal(:,2)==desOH,:);
		
		%if length(int(:,1))>0		
		%int0=int(randi(length(int(:,1))),1);
		
		if rOC==0.34
			int0=2+randi(2);
			borne1=0.33;
			borne2=0.35;
		elseif rOC==0.17;
			int0=5; %3+randi(5);
			borne1=0.16;
			borne2=0.175;
		elseif rOC==0.05;
			int0=10; %9+randi(5);
			borne1=0.04;
			borne2=0.05;
		elseif rOC==0.0;
			int0=30;
			borne1=-0.001;
			borne2=0.001;
		end
		
		X=['python2.7 Graphitics/GO.py ',num2str(int0),' ',num2str(rOH)];	
		system(X);
		decompose;
		P=load('./Graphitics/Positions.dat');
		charge=abs(sum(P(:,4)));
		nbOHbasal=length(P(P(:,3)==4,3));
		nbOHedge=length(P(P(:,3)==7,3));
		nbhyd=length(P(P(:,3)==5,3));
		if nbhyd==nbOHbasal+nbOHedge
			sum0=1;
		else
			sum0=0;
		end
		
		oxygen=P(P(:,3)==4 | P(:,3)==6 | P(:,3)==7 | P(:,3)==9 | P(:,3)==10 | P(:,3)==13,:);
		numberofoxygen=length(oxygen(:,1));
		oxygenEdge=P(P(:,3)==7);
		numberofoxygenEdge=length(oxygenEdge(:,1));
		carbon=P(P(:,3)==1 | P(:,3)==3 | P(:,3)==8 | P(:,3)==11 | P(:,3)==12,:);
		numberofcarbon=length(carbon(:,1));
		hydrogen=P(P(:,3)==2 | P(:,3)==5);
		numberofhydrogen=length(hydrogen(:,1));
		hydrogen=P(P(:,3)==2 | P(:,3)==5);
		
		numberofhydrogenEdge=36; % calculated with particule with OH=0;
		
		edgefraction=numberofoxygenEdge/numberofhydrogenEdge;
		
		
		carbonlayer=P(P(:,3)==1 | P(:,3)==3,:);
		Lx=max(carbonlayer(:,5))-min(carbonlayer(:,5));
		Ly=max(carbonlayer(:,6))-min(carbonlayer(:,6));
		carbonlayer(carbonlayer(:,5)==min(carbonlayer(:,5)),:)=[];
		carbonlayer(carbonlayer(:,5)==max(carbonlayer(:,5)),:)=[];
		carbonlayer(carbonlayer(:,6)==min(carbonlayer(:,6)),:)=[];
		carbonlayer(carbonlayer(:,6)==max(carbonlayer(:,6)),:)=[];
		nbcarbon=length(carbonlayer(:,1));
		L=max(Lx,Ly);
		
		basalfraction=nbOHbasal/nbcarbon;
		
		if  basalfraction<borne1 || basalfraction>borne2
			X=['basal fraction issue ',num2str(basalfraction), ' ',num2str(int0)];
			disp(' ');
			disp(X);
			disp(' ');
		elseif  sum0==0
			X=['weird atom issue'];
			disp(' ');
			disp(X);
			disp(' ');
		elseif charge>1e-5
			X=['charge issue'];
			disp(' ');
			disp(X);
			disp(' ');
		elseif edgefraction<0.29 || edgefraction>0.31
			X=['edge fraction issue ',num2str(edgefraction)];
			disp(' ');
			disp(X);
			disp(' ');
		else
			X=['all good ', num2str(int0)];
			disp(' ');
			disp(X);
			disp(' ');
		end		
					
		if  basalfraction<borne1 || basalfraction>borne2 || sum0==0 || charge>1e-5 || edgefraction<0.49 || edgefraction>0.51

			retry=1;
			system('rm ./GO.data');
			system('rm ./GO.xyz');
			system('rm Graphitics/*dat');

		else
			retry=0;
			
		end
	end	

	% save the particle
	n=1;
	nMax=1;
	create=0;
	while create==0
		X=['particle',num2str(n)];
		if exist(X,'dir')==7
			n=n+1;
			nMax=nMax+1;
		else
			create=1;
			
			if n==1
				
				Angles=load(['Graphitics/Angles.dat']);
				Bonds=load(['Graphitics/Bonds.dat']);
				Dihedrals=load(['Graphitics/Dihedrals.dat']);
				Impropers=load(['Graphitics/Impropers.dat']);
				MassCoeff=load(['Graphitics/MassCoeff.dat']);
				PairCoeffs=load(['Graphitics/PairCoeffs.dat']);
				Positions=load(['Graphitics/Positions.dat']);
				TypeAngle=load(['Graphitics/TypeAngle.dat']);
				TypeBond=load(['Graphitics/TypeBond.dat']);
				TypeDihedrals=load(['Graphitics/TypeDihedrals.dat']);
				TypeImpropers=load(['Graphitics/TypeImpropers.dat']);
				
				% remove doublons Impropers
				NewTypeImpropers(:,[2:3])=unique(TypeImpropers(:,[2:3]),'rows');
				for ii=1:length(NewTypeImpropers(:,1))
					NewTypeImpropers(ii,1)=ii;
				end
				
				for ii=1:length(Impropers(:,1))
					typ=Impropers(ii,2);
					coeff=TypeImpropers(typ,:);
					newtyp=NewTypeImpropers(NewTypeImpropers(:,[2:3])==coeff(1,[2:3]));
					newtyp=newtyp(1);
					Impropers(ii,2)=newtyp;
				end
							
				% remove doublons Dihedrals
				NewTypeDihedrals(:,[2:5])=unique(TypeDihedrals(:,[2:5]),'rows');
				for ii=1:length(NewTypeDihedrals(:,1))
					NewTypeDihedrals(ii,1)=ii;
				end
				
				for ii=1:length(Dihedrals(:,1))
					typ=Dihedrals(ii,2);
					coeff=TypeDihedrals(typ,:);
					newtyp=NewTypeDihedrals(NewTypeDihedrals(:,[2:5])==coeff(1,[2:5]));
					newtyp=newtyp(1);
					Dihedrals(ii,2)=newtyp;
				end
			
				
				% remove doublons Angles
				NewTypeAngle(:,[2:3])=unique(TypeAngle(:,[2:3]),'rows');
				for ii=1:length(NewTypeAngle(:,1))
					NewTypeAngle(ii,1)=ii;
				end
				
				for ii=1:length(Angles(:,1))
					typ=Angles(ii,2);
					coeff=TypeAngle(typ,:);
					newtyp=NewTypeAngle(NewTypeAngle(:,[2:3])==coeff(1,[2:3]));
					newtyp=newtyp(1);
					Angles(ii,2)=newtyp;
				end
				
				% remove doublons Bond
				NewTypeBond(:,[2:3])=unique(TypeBond(:,[2:3]),'rows');
				for ii=1:length(NewTypeBond(:,1))
					NewTypeBond(ii,1)=ii;
				end

				for ii=1:length(Bonds(:,1))
					typ=Bonds(ii,2);
					coeff=TypeBond(typ,:);
					newtyp=NewTypeBond(NewTypeBond(:,[2:3])==coeff(1,[2:3]));
					newtyp=newtyp(1);
					Bonds(ii,2)=newtyp;
				end
		
				save 'Positions.dat' -ascii Positions;
				save 'Bonds.dat' -ascii Bonds;
				save 'Angles.dat' -ascii Angles;
				save 'Dihedrals.dat' -ascii Dihedrals;
				save 'Impropers.dat' -ascii Impropers;
				
				save 'ffimpropers.dat' -ascii NewTypeImpropers;
				save 'ffdihedrals.dat' -ascii NewTypeDihedrals;
				save 'ffangles.dat' -ascii NewTypeAngle;
				save 'ffbonds.dat' -ascii NewTypeBond;
				save 'ffmass.dat' -ascii MassCoeff;
				save 'ffpair.dat' -ascii PairCoeffs;
				
				save 'basalfraction.dat' -ascii basalfraction;
				save 'edgefraction.dat' -ascii edgefraction;
			
				mkdir(X);
				file=sprintf('particle%d',n);
				fileRef=sprintf('Ref');

				movefile('Angles.dat',file);
				movefile('Bonds.dat',file);
				movefile('Dihedrals.dat',file);
				movefile('Impropers.dat',file);
				movefile('Positions.dat',file);
				
				movefile('basalfraction.dat',file);
				movefile('edgefraction.dat',file);

				copyfile('ffimpropers.dat',fileRef);
				copyfile('ffdihedrals.dat',fileRef);
				copyfile('ffangles.dat',fileRef);
				copyfile('ffbonds.dat',fileRef);
				copyfile('ffmass.dat',fileRef);
				copyfile('ffpair.dat',fileRef);
			
				movefile('ffimpropers.dat',file);
				movefile('ffdihedrals.dat',file);
				movefile('ffangles.dat',file);
				movefile('ffbonds.dat',file);
				movefile('ffmass.dat',file);
				movefile('ffpair.dat',file);
				
				movefile('GO.xyz',file);
			end	
			
		
		
				
			if n>1		
				% load reference force field
				ffmass=load(['Ref/ffmass.dat']);
				ffpair=load(['Ref/ffpair.dat']);
				ffimpropers=load(['Ref/ffimpropers.dat']);
				ffdihedrals=load(['Ref/ffdihedrals.dat']);
				ffangles=load(['Ref/ffangles.dat']);
				ffbonds=load(['Ref/ffbonds.dat']);
				
				% load new particle
				Angles=load(['Graphitics/Angles.dat']);
				Bonds=load(['Graphitics/Bonds.dat']);
				Dihedrals=load(['Graphitics/Dihedrals.dat']);
				Impropers=load(['Graphitics/Impropers.dat']);
				MassCoeff=load(['Graphitics/MassCoeff.dat']);
				PairCoeffs=load(['Graphitics/PairCoeffs.dat']);
				Positions=load(['Graphitics/Positions.dat']);
				TypeAngle=load(['Graphitics/TypeAngle.dat']);
				TypeBond=load(['Graphitics/TypeBond.dat']);
				TypeDihedrals=load(['Graphitics/TypeDihedrals.dat']);
				TypeImpropers=load(['Graphitics/TypeImpropers.dat']);
				
				massOK=0;
				pairOK=0;
				bondOK=0;
				anglOK=0;
				diheOK=0;
				imprOK=0;
				
				problem=0;

				
				if isequal(ffmass,MassCoeff)==1
				else
					problem=1;				
				end
				if isequal(ffpair,PairCoeffs)==1
				else
					problem=1;
				end
				if isequal(ffbonds,TypeBond)==1
				else
					% need to re-organise completely Bond
					for ii=1:length(Bonds(:,1))
						typii=Bonds(ii,2);
						val1=TypeBond(typii,2);
						val2=TypeBond(typii,3);
						% look for the idendity of this bond
						reftyp=ffbonds(ffbonds(:,2)==val1 & ffbonds(:,3)==val2,1);
						if length(reftyp)==1
							Bonds(ii,2)=reftyp;
						elseif length(reftyp)==0
							% need to add the bond
							problem=1;
							ffbonds(length(ffbonds(:,1))+1,:)=[length(ffbonds(:,1))+1 val1 val2];
							save 'Ref/ffbonds.dat' -ascii ffbonds;
							Bonds(ii,2)=length(ffbonds(:,1));
						elseif length(reftyp)>=2
							% doublon
							problem=1;
							stop2
						end
					end
				end
				if isequal(ffangles,TypeAngle)==1
				else
					% need to re-organise completely Angle
					for ii=1:length(Angles(:,1))
						typii=Angles(ii,2);
						val1=TypeAngle(typii,2);
						val2=TypeAngle(typii,3);
						% look for the idendity of this bond
						reftyp=ffangles(ffangles(:,2)==val1 & ffangles(:,3)==val2,1);
						if length(reftyp)==1
							Angles(ii,2)=reftyp;
						elseif length(reftyp)==0
							% need to add the angle
							ffangles(length(ffangles(:,1))+1,:)=[length(ffangles(:,1))+1 val1 val2];
							save 'Ref/ffangles.dat' -ascii ffangles;
							Angles(ii,2)=length(ffangles(:,1));
						elseif length(reftyp)>=2
							% doublon
							problem=1;
							stop3
						end
					end
				end
				if isequal(ffdihedrals,TypeDihedrals)==1
				else
					for ii=1:length(Dihedrals(:,1))
						typii=Dihedrals(ii,2);
						valD1=TypeDihedrals(typii,2);
						valD2=TypeDihedrals(typii,3);
						valD3=TypeDihedrals(typii,4);
						valD4=TypeDihedrals(typii,5);
						% look for the idendity of this bond
						reftyp=ffdihedrals(ffdihedrals(:,2)==valD1 & ffdihedrals(:,3)==valD2 & ffdihedrals(:,4)==valD3 & ffdihedrals(:,5)==valD4,1);
						if length(reftyp)==1
							Dihedrals(ii,2)=reftyp;
						elseif length(reftyp)==0
							% need to add the angle
							ffdihedrals(length(ffdihedrals(:,1))+1,:)=[length(ffdihedrals(:,1))+1 valD1 valD2 valD3 valD4];
							Dihedrals(ii,2)=length(ffdihedrals(:,1));
							save 'Ref/ffdihedrals.dat' -ascii ffdihedrals;
						elseif length(reftyp)>=2
							% doublon
							problem=1;
							stop4
						end
					end
				end
				if isequal(ffimpropers,TypeImpropers)==1
				else
					for ii=1:length(Impropers(:,1))
						typii=Impropers(ii,2);
						valD1=TypeImpropers(typii,2);
						valD2=TypeImpropers(typii,3);
						% look for the idendity of this bond
						reftyp=ffimpropers(ffimpropers(:,2)==valD1 & ffimpropers(:,3)==valD2,1);
						if length(reftyp)==1
							Impropers(ii,2)=reftyp;
						elseif length(reftyp)==0
							% need to add the angle
							ffimpropers(length(ffimpropers(:,1))+1,:)=[length(ffimpropers(:,1))+1 valD1 valD2];
							Impropers(ii,2)=length(ffimpropers(:,1));
							save 'Ref/ffimpropers.dat' -ascii ffimpropers;
						elseif length(reftyp)>=2
							% doublon
							problem=1;
							stop5
						end
					end
				end
				
				if problem==0
				
					mkdir(X);
					
					save 'Positions.dat' -ascii Positions;
					save 'Bonds.dat' -ascii Bonds;
					save 'Angles.dat' -ascii Angles;
					save 'Dihedrals.dat' -ascii Dihedrals;
					save 'Impropers.dat' -ascii Impropers;
					
					save 'basalfraction.dat' -ascii basalfraction;
					save 'edgefraction.dat' -ascii edgefraction;

					file=sprintf('particle%d',n);
					
					movefile('Angles.dat',file);
					movefile('Bonds.dat',file);
					movefile('Dihedrals.dat',file);
					movefile('Impropers.dat',file);
					movefile('Positions.dat',file);
					
					movefile('basalfraction.dat',file);
					movefile('edgefraction.dat',file);
					
					movefile('GO.xyz',file);
					
				else
				
					stopproblem	
					
				end
			end
		end
	end
end



























