class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_account
  before_action :find_transaction, only: %i[edit update show destroy]

  # Index action to render all transactions
  def index
    if params[:page]
      session[:trx_index_page] = params[:page]
    end

    @transactions = @account.transactions.with_balance.desc.paginate(page: session[:trx_index_page], per_page: 12)
    @custom_paginate_renderer = custom_paginate_renderer

    @search = params['search']
    if @search.present?
      @description = @search['description']
      @transactions = @transactions.where('description ILIKE ?', "%#{@description}%")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @transactions }
    end
  end

  # New action for creating transaction
  def new
    @transaction = @account.transactions.build
    @descriptions = @account.transactions.where('description != ?',"Starting Balance").order('description').uniq.pluck(:description)

    @autocomplete = @descriptions.to_json

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @transaction }
    end
  end

  # Create action saves the trasaction into database
  def create
    @transaction = @account.transactions.build(transaction_params)

    if @transaction.save
      redirect_to account_transactions_path, notice: 'Transaction was successfully created.'
    else
      render action: 'new'
    end
  end

  # Edit action retrieves the transaction and renders the edit page
  def edit
    @descriptions = @account.transactions.where('description != ?',"Starting Balance").order('description').uniq.pluck(:description)
    @autocomplete = @descriptions.to_json    
  end

  # Update action updates the transaction with the new information
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to account_transactions_path, notice: 'Transaction was successfully updated.' }
        format.xml { head :ok }
      else
        format.html { render action: 'edit' }
        format.xml { render xml: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # The show action renders the individual transaction after retrieving the the id
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @transaction }
    end
  end

  # The destroy action removes the transaction permanently from the database
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(account_transactions_url) }
      format.xml { head :ok }
    end
  end

  private

  def transaction_params
    params.require(:transaction) \
          .permit(:trx_date, :description, :amount, :trx_type, :memo, :attachment, :attachment_file_name, :page)
  end

  def find_account
    @account = current_user.accounts.find(params[:account_id])
    respond_to do |format|
      if !@account.active?
        format.html { redirect_to accounts_inactive_path, notice: 'Account is inactive' }
      else
        format.html
      end
    end
  end

  def find_transaction
    @transaction = @account.transactions.find(params[:id])
  end
end
