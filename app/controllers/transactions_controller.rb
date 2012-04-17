class TransactionsController < ApplicationController
  before_filter :authenticate_user!, :except => "receive"

  # GET /transactions
  # GET /transactions.xml
  def index
    @transactions = Transaction.where("sender_mobile = ? or receiver_mobile = ? or receiver_email = ?", current_user.mobile, current_user.mobile, current_user.email).order("created_at")
    #print request.env.inspect
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transactions }
      format.json  { render :json => @transactions }
    end
  end

  # GET /transactions/1
  # GET /transactions/1.xml
  def show
    @transaction = Transaction.where("id = ? and (sender_mobile = ? or receiver_mobile = ?)  ", params[:id], current_user.mobile, current_user.mobile).first
    unless @transacion
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transaction }
      format.json  { render :json => @transaction }
    end
    end
  end
  
  
  # POST /transactions
  # POST /transactions.xml
  def create
    @transaction = Transaction.new(params[:transaction])

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to(@transaction, :notice => 'Transaction was successfully created.') }
        format.xml  { render :xml => @transaction, :status => :created, :location => @transaction }
        format.json  { render :json => @transaction, :status => :created, :location => @transaction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
        format.json  { render :json => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /transactions/new
  # GET /transactions/new.xml
  def new
    @transaction = Transaction.new
    @transaction.build_document
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transaction }
    end
  end
=begin
  # GET /transactions/1/edit
  def edit
    #@transaction = Transaction.find(params[:id])
    @transaction = Transaction.where("id = ? and (sender_mobile = ? or receiver_mobile = ?)  ", params[:id], current_user.mobile, current_user.mobile)
  end

  # PUT /transactions/1
  # PUT /transactions/1.xml
  def update
    #@transaction = Transaction.find(params[:id])
    @transaction = Transaction.where("id = ? and (sender_mobile = ? or receiver_mobile = ?)  ", params[:id], current_user.mobile, current_user.mobile)

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to(@transaction, :notice => 'Transaction was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end
=end
  # DELETE /transactions/1
  # DELETE /transactions/1.xml
  def destroy
    #@transaction = Transaction.find(params[:id])
    @transaction = Transaction.where("id = ? and (sender_mobile = ? or receiver_mobile = ?)  ", params[:id], current_user.mobile, current_user.mobile)
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  end

  # Receive /transactions/receive
  def receive
    unless params[:transaction].blank? 
      unless (params[:transaction][:receiver_mobile].blank? or params[:transaction][:receiver_email].blank?) and params[:transaction][:document_secret].blank?
        @transaction = Transaction.get_document(params[:transaction][:receiver_mobile], params[:transaction][:receiver_email], params[:transaction][:document_secret]) 
        unless @transaction.blank?
          @document = @transaction.document
          respond_to do |format|
            format.html { send_file "public#{@document.doc.url(:original, false)}" , :type => "#{@document.doc_content_type}" }
            format.xml #receive.xml 
          end
        else
          respond_to do |format|
            @transaction = Transaction.new(params[:transaction])
            format.html { render :action =>  "receive"}
            format.xml  
          end
        end
      else
        respond_to do |format|
          @transaction = Transaction.new(params[:transaction])
          format.html { render :action =>  "receive"}
          format.xml  
         end
      end
    else
      @transaction = Transaction.new
      respond_to do |format|
        format.html # receive.html.erb
        format.xml  
      end
    end
  end
end
