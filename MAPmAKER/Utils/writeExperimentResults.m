function [  ] = writeExperimentResults(file, experimentNumber, initNumber, partialInfoNumber, falseEvicenceCounterstep1, trueEvidenceCounterstep1, solutionfoundstep1, solutionfoundstep2, planningtimestep1, planningtimestep2, planlengthstep1, planlengthstep2)

            fid=fopen(file,'a');
            if((solutionfoundstep1==1) && (solutionfoundstep2==1))
                Tr=(planningtimestep1/planningtimestep2);
                Lr=(planlengthstep1/planlengthstep2);
                fprintf(fid, '%d %d %d %d %d %f %f %d %d\n', [experimentNumber initNumber partialInfoNumber falseEvicenceCounterstep1 trueEvidenceCounterstep1 Tr Lr solutionfoundstep1 solutionfoundstep2]');
                 X=sprintf('%d %d %d %d %d %f %f %d %d \n', [experimentNumber initNumber partialInfoNumber falseEvicenceCounterstep1 trueEvidenceCounterstep1 Tr Lr solutionfoundstep1 solutionfoundstep2]');
               
            else
                Tr='-';
                Lr='-';
                fprintf(fid, '%d %d %d %d %d %c %c %d %d\n', [experimentNumber initNumber partialInfoNumber falseEvicenceCounterstep1 trueEvidenceCounterstep1 Tr Lr solutionfoundstep1 solutionfoundstep2]');
                X=sprintf('%d %d %d %d %d %c %c %d %d \n', [experimentNumber initNumber partialInfoNumber falseEvicenceCounterstep1 trueEvidenceCounterstep1 Tr Lr solutionfoundstep1 solutionfoundstep2]');
                 
            end
            fclose(fid);

end

