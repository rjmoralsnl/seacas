C Copyright(C) 1999-2020 National Technology & Engineering Solutions
C of Sandia, LLC (NTESS).  Under the terms of Contract DE-NA0003525 with
C NTESS, the U.S. Government retains certain rights in this software.
C 
C See packages/seacas/LICENSE for details


C=======================================================================
      SUBROUTINE PLTRTY(VAL,UMAP)
      REAL UMAP(*)
      REAL VAL
      REAL A(9),B(9)

      S = SIN(VAL)
      C = COS(VAL)
      DO 2260 I = 1,9
         A(I) = UMAP(21-1+I)
         B(I) = 0.
 2260 CONTINUE
      B(1) = C
      B(3) = S
      B(7) = -S
      B(9) = C
      B(5) = 1.
      CALL PLTROT(B,A,UMAP(21))
      RETURN

      END
