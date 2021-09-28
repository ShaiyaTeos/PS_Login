; The sql statement for executing the login check.
GameLogin_Exec:
    db "EXEC usp_Try_GameLogin_Taiwan '%s','%s', %I64d,'%s'", 0