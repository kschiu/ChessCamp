class Ability
  include CanCan::Ability

    def getStudentIDs(instructor_id)
        student_ids = []
        Instructor.find(instructor_id).camps.each do |c|
            student_ids << c.students.map {|s| s.id}
        end
        return student_ids.flatten
    end

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)

      if user.role? :admin
        can :manage, :all
      elsif user.role? :instructor
        can :read, Instructor
        can :read, Camp
        can :read, Curriculum
        can :read, Location
        can :read, Family
        can :read, Student do |student|
            getStudentIDs(user.instructor_id).include?(student.id)
        end
        can :update, Instructor do |instructor|  
          instructor.id == user.instructor_id
        end
      else
        can :read, :all
      end
    
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
