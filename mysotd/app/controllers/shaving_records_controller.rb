class ShavingRecordsController < ApplicationController
  before_action :set_shaving_record, only: [:show, :edit, :update, :destroy, :get_items]
  before_filter :authenticate_user!

  # GET /shaving_records
  # GET /shaving_records.json
  def index
    #@shaving_records = ShavingRecord.all
    @shaving_records = ShavingRecord.where(user_id: current_user.id)
  end

  # GET /shaving_records/1
  # GET /shaving_records/1.json
  def show
  end

  # GET /shaving_records/new
  def new
    @shaving_record = ShavingRecord.new
    @item = Item.where(user_id: current_user.id)
    @shaving_record.items = @item

    puts params[:item_ids]
    puts 'new!'

    #@shaving_record.shaving_items << ShavingItem.new {:item_ids}
    #@shaving_item = @shaving_record.shaving_items.build(shaving_record_params)

    #this
    #shaving_item = Shaving_item.new
    #shaving_item.shaving_record_id = @shaving_record.id
  end

  # GET /shaving_records/1/edit
  def edit
  end

  # POST /shaving_records
  # POST /shaving_records.json
  def create
    @shaving_record = ShavingRecord.new(shaving_record_params)
    #@shaving_item = @shaving_record.shaving_items.build(params[:item_ids]) #this

    shaving_item = ShavingItem.new
    @shaving_items = params['shave_record'][:item_ids]

    puts @shaving_items
    puts 'create started!!'




    respond_to do |format|
      if @shaving_record.save

        #create loop to add multiple items to shaving items
        @shaving_items.each do |item|
          puts 'shaving record', @shaving_record.id
          puts 'item', item
          shaving_item.shaving_record_id = @shaving_record.id
          shaving_item.item_id = item
          shaving_item.save
        end

        format.html { redirect_to @shaving_record, notice: 'Shaving record was successfully created.' }
        format.json { render :show, status: :created, location: @shaving_record }
      else
        format.html { render :new }
        format.json { render json: @shaving_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shaving_records/1
  # PATCH/PUT /shaving_records/1.json
  def update
    respond_to do |format|
      if @shaving_record.update(shaving_record_params)
        format.html { redirect_to @shaving_record, notice: 'Shaving record was successfully updated.' }
        format.json { render :show, status: :ok, location: @shaving_record }
      else
        format.html { render :edit }
        format.json { render json: @shaving_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shaving_records/1
  # DELETE /shaving_records/1.json
  def destroy
    @shaving_record.destroy
    respond_to do |format|
      format.html { redirect_to shaving_records_url, notice: 'Shaving record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Get items for shave
  def get_items
    @items = Item.where(user_id: current_user.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shaving_record
      @shaving_record = ShavingRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shaving_record_params
      #params.require(:shaving_record).permit(:description, :date, :rating, :user_id, :picture)
      params.require(:shaving_record).permit(:description, :date, :rating, :picture,
                                             items: [:name, :id], :item_ids =>[]).merge(user_id: current_user.id)
    end

end
