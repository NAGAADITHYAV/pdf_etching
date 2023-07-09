class ImpPdfsController<ApplicationController
    def change
        ImpTempPdf.new(params)
        render json:{ status: "completed"}, status: :ok
    end
end