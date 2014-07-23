WickedPdf.config = {
    :exe_path => Rails.env.development? ? '/usr/local/bin/wkhtmltopdf' : 'wkhtmltopdf'
    # :exe_path => 'C:\\Program Files\\wkhtmltopdf\\bin\\wkhtmltopdf.exe'
}