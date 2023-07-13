class NeedPdfsController < ApplicationController
    def change
        NeedPdf.new(params)
        render json:{ status: "completed"}, status: :ok
    end
end