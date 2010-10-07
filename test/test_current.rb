require 'helper'

class UsersController < ActionController::Base
  def new
  end
  def edit
  end
end

class JobsController < ActionController::Base
  def new
  end
end

class TestCurrent < ActionView::TestCase

  include Current

  context "When on the users controller" do
    setup do
      @controller = UsersController.new
      self.stubs(:controller).returns(@controller)
      @request = ActionController::TestRequest.new
      @request.stubs(:host).returns('localhost:3000')
      @controller.stubs(:request).returns(@request)
      @response = ActionController::TestResponse.new
      self.stubs(:controller_name).returns('users')
      self.stubs(:action_name).returns('new')
    end
    
    context "controller_is" do
      should "be true for users" do
        assert controller_is('users')
      end

      should "be true for users/new" do
        assert controller_is('users', 'new')
      end

      should "be false for jobs" do
        assert !controller_is('jobs')
      end
    end

    context "action_is" do
      should "be true if current action is in the supplied list" do
        assert action_is('new')
        assert action_is('new', 'edit')
      end

      should "be false if current action is not in the supplied list" do
        assert !action_is('edit')
      end
    end

    context "partial_is" do
      should "be true if params[:partial] is the specified value" do
        self.stubs(:params).returns({ :partial => 'boards' })
        assert partial_is('boards')
      end

      should "be false if params[:partial] is not the specified value" do
        self.stubs(:params).returns({ :partial => 'askjfafew' })
        assert !partial_is('boards')
      end
    end

    context "controller_action_is" do
      should "be true if for current controller/action combination" do
        assert controller_action_is('users', 'new')
      end

      should "be false for incorrect controller/action combination" do
        assert !controller_action_is('accounts', 'edit')
        assert !controller_action_is('jobs', 'new')
      end
    end

    context "active_if" do
      should "return active if true" do
        assert_equal 'active', active_if(true)
      end

      should "return inactive if false" do
        assert_equal 'inactive', active_if(false)
      end
    end
  end
end
