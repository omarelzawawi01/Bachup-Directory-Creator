hello:
	@mkdir -p $(backupdir)
	@./lab2test.sh $(dir) $(backupdir) $(inttime) $(maxback)
