.set RECLEN_FIRSTNAME,    40
.set RECLEN_LASTNAME,     40
.set RECLEN_ADDRESS,     240
.set RECLEN_AGE,           4
.set RECLEN, RECLEN_FIRSTNAME + RECLEN_LASTNAME + RECLEN_ADDRESS + RECLEN_AGE

.set RECOFFSET_FIRSTNAME,   0
.set RECOFFSET_LASTNAME,    RECLEN_FIRSTNAME
.set RECOFFSET_ADDRESS,     RECOFFSET_LASTNAME + RECLEN_LASTNAME
.set RECOFFSET_AGE,         RECOFFSET_ADDRESS  + RECLEN_ADDRESS

