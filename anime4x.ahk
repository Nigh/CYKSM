Class anime4x
{
	static state := 0
	static afterfunc := ""
	static callbackfunc := ""
	static inputfile := ""
	static outputfile := ""
	static input_bitmap := ""
	static output_bitmap := ""

	static inputpath(inputfile) {
		this.inputfile := inputfile
		this.input_bitmap := Gdip_CreateBitmapFromFile(this.inputfile)
		Return this.input_bitmap
	}
	static outputpath(outputfile) {
		this.outputfile := outputfile
	}

	static after(func) {
		this.afterfunc := func
	}

	static callback(func) {
		this.callbackfunc := func
	}

	static go() {
		if not FileExist(this.inputfile) {
			MsgBox "未找到输入图片，请重新拖入"
			return
		}
		if FileExist(this.outputfile) {
			FileDelete this.outputfile
		}
		this.state := 1
		SetTimer(this.callbackfunc, 150)
		RunWait(A_Temp '\CYKSM\rn-vulkan.exe -i "' this.inputfile '" -o "' this.outputfile '" -n realesrgan-x4plus-anime -m models_realesrgan', , "Hide")
		SetTimer(this.callbackfunc, 0)
		this.state := 0
		this.output_bitmap := Gdip_CreateBitmapFromFile(this.outputfile)
		SetTimer(this.afterfunc, -1)
	}
}
