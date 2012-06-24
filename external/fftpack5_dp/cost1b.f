CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
C   FFTPACK 5.0
C   Copyright (C) 1995-2004, Scientific Computing Division,
C   University Corporation for Atmospheric Research
C   Licensed under the GNU General Public License (GPL)
C
C   Authors:  Paul N. Swarztrauber and Richard A. Valent
C
C   $Id: cost1b.f,v 1.2 2006-11-21 01:10:17 haley Exp $
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

      SUBROUTINE DCOST1B(N,INC,X,LENX,WSAVE,LENSAV,WORK,LENWRK,IER)
      INTEGER N,INC,LENX,LENSAV,LENWRK,IER
      DOUBLE PRECISION X(INC,*),WSAVE(LENSAV),WORK(LENWRK)
C
      IER = 0
      IF (LENX.LT.INC* (N-1)+1) THEN
          IER = 1
          CALL DXERFFT('COST1B',6)
          GO TO 100
      ELSE IF (LENSAV.LT.2*N+INT(LOG(DBLE(N)))+4) THEN
          IER = 2
          CALL DXERFFT('COST1B',8)
          GO TO 100
      ELSE IF (LENWRK.LT.N-1) THEN
          IER = 3
          CALL DXERFFT('COST1B',10)
          GO TO 100
      END IF
C
      CALL DCOSTB1(N,INC,X,WSAVE,WORK,IER1)
      IF (IER1.NE.0) THEN
          IER = 20
          CALL DXERFFT('COST1B',-5)
      END IF
C
  100 CONTINUE
      RETURN
      END