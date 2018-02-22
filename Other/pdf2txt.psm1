Add-Type -Path ".\itextsharp-all-5.5.11\itextsharp-dll-core\itextsharp.dll"

Function pdf2txt()
{
	Param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)][Alias("FullName")][String]$Path
	)
	Process {
		#construct reader object and prepare for reading
		$reader = New-Object iTextSharp.text.pdf.PdfReader($Path)
		
		#read pdf
		$ret = [iTextSharp.text.pdf.parser.PdfTextExtractor]::GetTextFromPage($reader, 1)
		
		#clean up references
		$reader.Dispose()
		return $ret
	}
}

Export-ModuleMember -Function pdf2txt