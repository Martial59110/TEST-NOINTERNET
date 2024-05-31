      *    Cobol est l'acronyme de "COmmun Buisness Oriented Language"
      
       IDENTIFICATION DIVISION.
       PROGRAM-ID. pgtest.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TEST-FILE ASSIGN TO 'datassur.dat'
                  ORGANIZATION IS LINE SEQUENTIAL
                  FILE STATUS IS INPUT-STATUS.
           SELECT OUTPUT-FILE ASSIGN TO 'rapport.dat'
                  ORGANIZATION IS LINE SEQUENTIAL
                  FILE STATUS IS OUTPUT-STATUS.
       DATA DIVISION.
       FILE SECTION.
       FD  TEST-FILE.
       01  ALL-DATA.
           05  NUMBERSS PIC X(8).
           05  STAR1 PIC X.
           05  NAMES PIC X(14).
           05  STAR2 PIC X.
           05  LIBELLE PIC X(14).
           05  STAR3 PIC X.
           05  SOCIETY PIC X(41).
           05  STAR4 PIC X.
           05  STATUS-W PIC X(8).
           05  STAR5 PIC X.
           05  NUMBER1 PIC X(8).
           05  STAR6 PIC X.
           05  NUMBER2 PIC X(8).
           05  STAR7 PIC X.
           05  SALARY PIC X(9).
           05  STAR8 PIC X.
           05  EURO PIC X(3).
    
       
       FD  OUTPUT-FILE.
       01  OUT-DATA PIC X(200).

       WORKING-STORAGE SECTION.
       01  ALL-STARS PIC X(200) VALUE ALL "*".
       01  HEADER.
           05 FILLER PIC X(19) VALUE ALL SPACES.
           05 FILLER PIC X(19) VALUE "Rapport de synthese".
           05 FILLER PIC X(5) VALUE ALL SPACES.
           05 FILLER PIC X(24) VALUE "Auteur : Martial Floquet".
           05 FILLER PIC X(5) VALUE ALL SPACES.
           05 FILLER PIC X(24) VALUE "Date : 31/05/2024".
       01  BODY-HEADER.
           05 FILLER PIC X(5) VALUE ALL SPACES.
           05 FILLER PIC X(19) VALUE "NAMES :".
           05 FILLER PIC X(5) VALUE ALL SPACES.
           05 FILLER PIC X(14) VALUE "LIBELLE :".
           05 FILLER PIC X(5) VALUE ALL SPACES.
           05 FILLER PIC X(41) VALUE "SOCIETY :".
          
           05 FILLER PIC X(8) VALUE "STATUT :".
           05 FILLER PIC X(5) VALUE ALL SPACES.
           05 FILLER PIC X(8) VALUE "SALARY :".
       01  BODY.
           05 FILLER PIC X(5) VALUE ALL SPACES.
           05 WS-NAMES PIC X(14).
           05 FILLER PIC X(5) VALUE ALL SPACES.
           05 WS-LIBELLE PIC X(14).
           05 FILLER PIC X(5) VALUE ALL SPACES.
           05 WS-SOCIETY PIC X(41).
           05 FILLER PIC X(5) VALUE ALL SPACES.
           05 WS-STATUS PIC X(8).
           05 FILLER PIC X(5) VALUE ALL SPACES.
           05 WS-SALARY PIC 999999V99.
       01  FOOTER.
           05 FILLER PIC X(5) VALUE ALL SPACES.
           05 FILLER PIC X(19) VALUE "Salaire total :".
           05 TOTAL PIC 999999V99.
           05 FILLER PIC X(5) VALUE "euros".
           05 FILLER PIC X(20) VALUE "Nombre de societes :".
           05 COUNTER PIC 9(2).

       01  INPUT-STATUS PIC X(2).
           88 endofile VALUE "10".
           88 okfile VALUE "00".
       01  OUTPUT-STATUS PIC X(2).
           88 output-ok VALUE "00".
       01  WS-IDX PIC 999 VALUE 0.
     
       PROCEDURE DIVISION.

       MAIN-PROGRAM.
           PERFORM 1000-OPEN-FILE.
     
           STOP RUN.

        

       1000-OPEN-FILE.

           OPEN INPUT TEST-FILE
                OUTPUT OUTPUT-FILE. 
  
           WRITE OUT-DATA FROM ALL-STARS.
           WRITE OUT-DATA FROM HEADER.
           WRITE OUT-DATA FROM ALL-STARS.
           WRITE OUT-DATA FROM BODY-HEADER.
           WRITE OUT-DATA FROM SPACES.


           PERFORM UNTIL INPUT-STATUS = "10"
           READ TEST-FILE
           MOVE NAMES TO WS-NAMES
           MOVE LIBELLE TO WS-LIBELLE
           MOVE SOCIETY TO WS-SOCIETY
           MOVE STATUS-W  TO WS-STATUS
           MOVE SALARY TO WS-SALARY
           ADD WS-SALARY TO TOTAL
           ADD 1 TO COUNTER
           PERFORM 3000-WRITE-FILE
           END-PERFORM.
           
           CLOSE TEST-FILE.
           WRITE OUT-DATA  FROM ALL-STARS.
           WRITE OUT-DATA  FROM FOOTER.

           
           CLOSE OUTPUT-FILE.

    

       3000-WRITE-FILE.

            WRITE OUT-DATA  FROM BODY.
    
           
           
