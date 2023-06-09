class PdfsController<ApplicationController
    def change
        TempPdf.new(params)
    end
end