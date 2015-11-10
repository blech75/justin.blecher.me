jQuery(function($){

  var ACTIVE_CLASS = 'active';
  var INACTIVE_CLASS = 'inactive';

  function CareerNav($jobs, $jobs_nav) {
    // array all jobs; assumes reverse chron order
    this.jobs = [];

    this.$jobs_nav = $jobs_nav;
    this.$jobs = $jobs;

    this.init();
  }

  CareerNav.prototype.init = function() {
    this.$all_jobs = this.$jobs.children(); // #jobs .job

    this.$all_jobs.not(':first').addClass(INACTIVE_CLASS);
    this.$all_jobs.first().addClass(ACTIVE_CLASS);
    this.$jobs.addClass(ACTIVE_CLASS);

    this.$jobs_nav.append(this.createNav());
    this.$jobs_nav.on('click', 'li', this.showJob.bind(this));

    // this.showJob();

  };

  CareerNav.prototype.createNav = function() {
    var $nav = $('<ul>');

    // remember, DOM order is reverse chron
    var career_length = this.calcuateLength(this.$all_jobs.last(), this.$all_jobs.first());

    function calculateNavItemWidth(date_start, date_end, career_length) {
      var date_diff = Date.parse(date_end) - Date.parse(date_start);

      var percent = Math.round((date_diff / career_length) * 10000)/100;
      return percent + "%";
    }

    this.$all_jobs.each(function(idx, el) {
      var $j = $(el);

      var $title = $j.find('h3');

      var $job = $('<li>');
      $job.attr('title', $title.text().trim());

      var item_width = calculateNavItemWidth($j.data('date-start'), $j.data('date-end'), career_length);
      $job.width(item_width);

      // store a reference to the current dom node so we can manipulate it
      // later without re-querying the DOM
      $job[0].job_item = $j[0];

      if (idx === 0) {
        $job.addClass(ACTIVE_CLASS);
      }

      $nav.append($job);
    });

    return($nav);
  };

  CareerNav.prototype.calcuateLength = function($first_job, $last_job) {
    var career_start_date = Date.parse($first_job.data('date-start'));
    var career_end_date = Date.parse($last_job.data('date-end'));

    // in ms
    return (career_end_date - career_start_date);
  };

  CareerNav.prototype.showJob = function(e) {
    var $el;

    if (e) {
      $el = $(e.target);
    } else {
      $el = this.$jobs_nav.find('li').first();
    }

    var $current_job_item = $($el.get(0).job_item);

    // reset classes on all nav items and activate the clicked item
    $el.parent().children().removeClass(ACTIVE_CLASS).addClass(INACTIVE_CLASS);
    $el.removeClass(INACTIVE_CLASS).addClass(ACTIVE_CLASS);

    // reset classes on all jobs; add inactive to all
    this.$all_jobs.removeClass(ACTIVE_CLASS).addClass(INACTIVE_CLASS);

    // the current job item should only have an 'active' class
    $current_job_item.removeClass(INACTIVE_CLASS).addClass(ACTIVE_CLASS);

    function calculateJobOffset(all_jobs) {
      var cumulative_height = 0;

      for (var i=0; i < all_jobs.length; i++) {
        if ($(all_jobs[i]).hasClass(ACTIVE_CLASS)) {
          break;
        }
        cumulative_height += $(all_jobs[i]).outerHeight();
      }

      return -cumulative_height;
    }

    this.$all_jobs.first().css('margin-top', calculateJobOffset(this.$all_jobs) + "px");
    this.$jobs.height($current_job_item.height());

  };

  var careerNav = new CareerNav($('#jobs'), $('nav#jobs-nav'));

}(jQuery));
