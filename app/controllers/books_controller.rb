class BooksController < ApplicationController
    def search
		if params[:keyword].present?
			@books = RakutenWebService::Books::Total.search(keyword: params[:keyword])
		end
	end

	def index
		@details = Detail.all
	end

	def new
	end

	def create
		detail = Detail.all
		detail.destroy_all

		xlsx = Roo::Excelx.new('app/assets/excel/Book1.xlsx')
		sheet = xlsx.sheet('Sheet1')

		i = 1
		loop do
			i = i + 1
			@detail = Detail.new
			@detail.genre_id = sheet.cell(i,1)
			@detail.genre = sheet.cell(i,2)
			@detail.magazine = sheet.cell(i,3)
            @detail.save
			unless @detail.genre_id.present?
				break
			end
		end
		redirect_to :action => "index"
	end
	def detail_params
		params.require(:detail).permit(:genre_id, :genre, :magazine)
	end
end
