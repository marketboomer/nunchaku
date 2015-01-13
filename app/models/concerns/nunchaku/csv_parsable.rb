module Nunchaku
  module CsvParsable
    extend ActiveSupport::Concern

    included do
      attr_accessor :csv_file # any IO based class that responds to read()
    end

    def csv_parse(options = {}, &block)
      CSV.parse(csv_encoded_content, options.merge!({:col_sep => col_sep})) do |row|
        block.call(row)
      end
    end

    private

    def csv_encoded_content
      @csv_encoded_content ||= (strip_bom << csv_content[4..csv_content.length]).force_encoding(encoding).encode("UTF-8")
    end

    def csv_content
      @csv_content ||= self.csv_file.read
    end

    def strip_bom
      return bom[2..3] if /UTF-16/ =~ encoding
      return '' if /UTF-32/ =~ encoding
      return bom[3] if bom[0] == 239.chr && bom[1] == 187.chr && bom[2] == 191.chr
      bom
    end

    def encoding
      @encoding ||= utf16le || utf16be || utf32le || utf32be || "UTF-8"
    end

    def bom
      @bom ||= csv_content.b[0..3]
    end

    def col_sep
      line = csv_encoded_content.lines.first
      ["\t", ',', ';'].map { |sep| sep if Regexp.new(sep) =~ line }.compact.first || ',' # double quotes and a non-literal array are important here.
    end

    def utf16le
      "UTF-16LE" if bom[0] == 255.chr && bom[1] == 254.chr
    end

    def utf16be
      "UTF-16BE" if bom[0] == 254.chr && bom[1] == 255.chr
    end

    def utf32le
      "UTF-32LE" if bom[0] == 255.chr && bom[1] == 254.chr && bom[2] == 0.chr && bom[3] == 0.chr
    end

    def utf32be
      "UTF-32BE" if bom[0] == 0.chr && bom[1] == 0.chr && bom[2] == 254.chr && bom[3] == 255.chr
    end
  end
end