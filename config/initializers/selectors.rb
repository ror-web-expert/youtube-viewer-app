VALLEY_WISE_HEALTH = {
  "listing_selector": {
    "job-container-list": "ul .result-item",
    "main_selector": {
      "title": ".item-title a",
      "source_url": ".item-title a"
    },
    "pagination": {
      "next_button": "a.page-link-next:not([aria-disabled='true'])"
    },
    "response_selector": {
      "location": ".item-title .location",
      "state": ".item-title .city-state"
    }
  },
  "detail_selector": {
    "job-detail-container": ".content",
    "job_does_not_exist": {
      "not_found_container": "",
      "not_found_text": ""
    },
    "response_selector": {
      "title": ".job-title",
      "facility": ".job-description-content p:contains('Facility:')",
      "department": ".job-description-content p:contains('Department:')",
      "schedule": ".job-description-content p:contains('Schedule:')",
      "shift_type": ".job-description-content p:contains('Shifts:')",
      "apply_now_url": ".job-addl-info .ApplyButton",
      "salary_range": ".job-addl-info .job-payrange",
      "posted_date": ".job-addl-info .date span",
      "job_status": ".job-addl-info .job-status span",
      "job_refernce_id": ".job-addl-info .job-ref",
      "get_from_content": ".job-body .job-description-content",
      "description_raw_html": {
        "get_paragraph": ".job-description-content #descHeader",
        "next_element": true,
        "inner_html": true
      }
    }
  },
  "logo": "valley_wise_health.png"
}

THRIVE_SPC = {
  "listing_selector": {
    "job-container-list": "#careers .career-card",
    "main_selector": {
      "title": ".career-details a",
      "source_url": ".career-details a"
    },
    "scrolling": {
      "scroll_count": "7"
    },
    "response_selector": {
      "location": ".career-details .column p.blue"
    }
  },
  "detail_selector": {
    "job-detail-container": ".is-multiline",
    "job_does_not_exist": {
      "not_found_container": "",
      "not_found_text": ""
    },
    "response_selector": {
      "job_type": ".job-content p:contains('Full Time')",
      "description_raw_html": ".column[1]",
      "get_from_content": ".column[1]"
    }
  },
  "logo": "thrive_spc.png"
}

HONOR_HEALTH = {
  "listing_selector": {
    "job-container-list": ".job-results-container .mat-expansion-panel",
    "main_selector": {
      "title": ".job-title a",
      "source_url": ".job-title a"
    },
    "pagination": {
      "next_button": ".mat-paginator-range-actions .mat-paginator-navigation-next:not([disabled='true'])"
    },
    "response_selector": {
      "location": ".job-result__location .label-container",
      "remote_type": ".job-result__location .label-container .telecommute .translate",
      "job_type": ".description-container .tags2",
      "working_hours": ".job-card-result-container .tags4"
    }
  },
  "detail_selector": {
    "job-detail-container": ".job-description-container",
    "job_does_not_exist": {
      "not_found_container": ".not-found-container .not-found-content h2",
      "not_found_text": "The page you are looking for no longer exists."
    },
    "response_selector": {
      "title": ".columns .left .header-section h1",
      "facility": "ul.meta-data-options li[1] span",
      "category": "ul.meta-data-options li[2] span",
      "department": "ul.meta-data-options li[5] span",
      "schedule": "ul.meta-data-options li[4] span",
      "shift_type": "ul.meta-data-options li[3] span",
      "Req Id": "ul.meta-data-options li[6] span",
      "apply_now_url": ".right .sticky-item .apply",
      "job_refernce_id": "ul.meta-data-options li[6] span",
      "job_description_heading": ".columns .left .main-description-section h2",
      "description_raw_html": ".columns .left .main-description-body"
    }
  },
  "logo": "honor_health.png"
}

MAYO_CLINIC = {
  "listing_selector": {
    "cookies_modal": {
      "id": "#system-ialert-button",
      "button_text": "Accept"
    },
    "job-container-list": "#search-results-list ul[2] li",
    "main_selector": {
      "title": "a",
      "source_url": "a"
    },
    "pagination_show_all": {
      "show_all_button": "#pagination-bottom .pagination-show-all"
    },
    "response_selector": {
      "location": ".job-location"
    }
  },
  "detail_selector": {
    "cookies_modal": {
      "id": ".system-ialert-button",
      "button_text": "Accept"
    },
    "job_does_not_exist": {
      "not_found_container": "#content .generic-container p",
      "not_found_text": "We are sorry this job post no longer exists. Luckily, we have other jobs you might also be interested in: Search jobs"
    },
    "job-detail-container": "#content",
    "response_selector": {
      "title": ".job-description .title-wrapper h2",
      "job_refernce_id": ".job-description .title-wrapper .job-id",
      "job_type": ".other-stuff li[2]",
      "department": ".deets p[4]",
      "second_department": ".other-stuff li[3]",
      "location": ".job-description .title-wrapper .ico-location",
      "posted_date": ".job-description .title-wrapper .job-date",
      "apply_now_url": ".button-wrapper a.job-apply",
      "description_raw_html": "#core_jd-top",
      "get_from_content": "#jd-toggle-wrap .ats-description",
      "salary_range": {
        "next_sibling": true,
        "next_element": "true",
        "element_css": "b:contains('Compensation Detail')"
      },
      "short_description": {
        "next_sibling": true,
        "next_element": "true",
        "element_css": "b:contains('Site Description')"
      }
    }
  },
  "logo": "mayo_clinic.png"
}

COMMON_SPIRIT = {
  "listing_selector": {
    "job-container-list": "#search-results-list ul li",
    "cookies_modal": {
      "id": "#igdpr-button",
      "button_text": "Accept"
    },
    "main_selector": {
      "title": "a .job-information h2",
      "source_url": "a[1]"
    },
    "pagination": {
      "next_button": ".pagination-paging a.next:not([class='next disabled'])"
    },
    "response_selector": {
      "location": ".job-information .job-location",
      "department": ".job-information .job-department"
    }
  },
  "detail_selector": {
    "job-detail-container": "#content",
    "job_does_not_exist": {
      "not_found_container": "#content .container",
      "not_found_text": "We are sorry this job post no longer exists. Luckily, we have other jobs you might also be interested in: Search jobs"
    },
    "response_selector": {
      "department": ".ajd_overview__quick-facts .ajd_overview__quick-fact--department",
      "job_type": ".job-details-info .job-info:contains('Employment Type')",
      "schedule": ".job-details-info .job-date[5]",
      "shift_type": ".job-details-info .job-info:contains('Shift')",
      "remote_type": ".job-details-info .job-info:contains('Remote')",
      "apply_now_url": ".ajd_header__job-buttons a",
      "job_refernce_id": ".job-details-info .job-id",
      "get_from_content": ".job-info",
      "description_raw_html": ".ats-description"
    }
  },
  "logo": "common_spirit.png"
}

USPI = {
  "listing_selector": {
    "job-container-list": "#search-results-list ul li",
    "main_selector": {
      "title": "a h2",
      "source_url": "a"
    },
    "pagination_show_all": {
      "show_all_button": ".pagination-all .pagination-show-all"
    },
    "response_selector": {
      "location": ".job-location"
    }
  },
  "detail_selector": {
    "job_does_not_exist": {
      "not_found_container": ".max-width.misc-content p",
      "not_found_text": "We are sorry this job post no longer exists. Luckily, we have other jobs you might also be interested in: Search jobs"
    },
    "job-detail-container": "#anchor-job-details .job-description",
    "response_selector": {
      "facility": ".jd-job-info-wrap .job-facility",
      "location": ".jd-job-info-wrap .job-location",
      "apply_now_url": ".jd-btn-wrap .job-apply",
      "posted_date": ".jd-job-info-wrap .job-date",
      "job_refernce_id": ".jd-job-info-wrap .job-id",
      "description_raw_html": "#jd-wrap",
      "get_from_content": "#jd-wrap"
    }
  },
  "logo": "uspi.png"
}

ENVITA = {
  "listing_selector": {
    "job-container-list": "#resumator-jobs .resumator-job",
    "main_selector": {
      "title": ".resumator-job-title",
      "source_url": ".resumator-job-view-details a"
    },
    "response_selector": {
      "location": ".resumator-job-info"
    }
  },
  "detail_selector": {
    "job_does_not_exist": {
      "not_found_container": ".job-header .container",
      "not_found_text": "Hiring for this position has been put on hold at this time.\nClick here to view more opportunities at Envita Medical Center."
    },

    "job-detail-container": "main",
    "response_selector": {
      "job_type": ".job-attributes-container #resumator-job-employment",
      "location": ".job-attributes-container div[1]",
      "schedule": ".job-details #job-description p[5]",
      "salary_range": ".job-details #job-description p[3]",
      "description_raw_html": ".job-details #job-description",
      "get_from_content": ".job-details #job-description"
    }
  },
  "logo": "envita.png"
}

FRESENIUS_MEDICAL_CARE = {
  "listing_selector": {
    "job-container-list": ".sc-htpNat .sc-TuwoP",
    "main_selector": {
      "title": "div[1] a",
      "source_url": "div[1] a"
    },
    "response_selector": {
      "location": "div[1] .richText"
    },
    "pagination": {
      "next_button": "#JobSearchResultsWrapper a .sc-epGmkI button.sc-dphlzf.fQTloK:not([disabled]",
      next_button_text: ">>"
    },
  },
  "detail_selector": {
    "job_does_not_exist": {
      "not_found_container": "#elm_TEXT h4",
      "not_found_text": "This job ad has been deactivated."
    },
    "job-detail-container": ".hSHIcX",
    "response_selector": {
      "job_type": "#JobDetailOverview div[6] .kowrXr",
      "location": ".logoPrintable span[1]",
      "apply_now_url": ".jd-btn-wrap .job-apply",
      "department": "#JobDetailOverview div[7] .kowrXr",
      "job_refernce_id": "#JobDetailOverview div[8] .kowrXr",
      "get_from_content": "#JobDetailDescription",
      "description_raw_html": "#JobDetailDescription"
    }
  },
  "logo": "fresenius_medical_care.png"
}

IQVIA = {
  "listing_selector": {
    "job-container-list": "#search-results-list li",
    "main_selector": {
      "title": "a h2",
      "source_url": "a"
    },
    "response_selector": {
      "location": "a .job-info-wrap .job-location"
    }
  },
  "detail_selector": {
    "job_does_not_exist": {
      "not_found_container": ".misc-content-inner p",
      "not_found_text": "We are sorry this job post no longer exists. Luckily, we have other jobs you might also be interested in: Search all jobs"
    },
    "job-detail-container": ".job-description",
    "response_selector": {
      "job_type": ".jd-jobinfo .job-type",
      "job_refernce_id": ".jd-jobinfo .job-id",
      "apply_now_url": ".jd-jobinfo-wrap a",
      "get_from_content": ".ats-description",
      "description_raw_html": ".ats-description"
    }
  },
  "logo": "iqvia.png"
}

LIFE_POINT_HEALTH = {
  "listing_selector": {
    "job-container-list": "#search-results-list li",
    "main_selector": {
      "title": "a h2",
      "source_url": "a"
    },
    "response_selector": {
      "location": "a .job-location"
    }
  },
  "detail_selector": {
    "job_does_not_exist": {
      "not_found_container": ".max-width-padding.secondary-wrapper",
      "not_found_text": "We are sorry this job post no longer exists. Luckily, we have other jobs you might also be interested in: Search jobs"
    },
    "job-detail-container": ".job-description",
    "response_selector": {
      "job_refernce_id": ".job-info__wrap .job-id",
      "facility": ".job-info__wrap .job-brand",
      "category": ".job-info__wrap .job-cat",
      "apply_now_url": ".job-buttons .job-apply",
      "get_from_content": ".read-more .ats-description",
      "description_raw_html": ".read-more .ats-description"
    }
  },
  "logo": "life_point_health.png"
}

BLUE_MOUNTAIN_HOSPITAL = {
  "listing_selector": {
    "job-container-list": "#pt-cv-gls-R .pt-cv-content-item",
    "main_selector": {
      "title": ".pt-cv-ifield .pt-cv-title a",
      "source_url": ".pt-cv-ifield .pt-cv-title a"
    },
    "response_selector": {
      "location": "a .job-location"
    }
  },
  "detail_selector": {
    "job_does_not_exist": {
      "not_found_container": ".entry-404 .center-text",
      "not_found_text": "The page you are looking for is no longer here, or never existed in the first place (bummer). You can try searching for what you are looking for using the form below. If that still doesn't provide the results you are looking for, you can always start over from the home page."
    },
    "job-detail-container": ".entry-wrap",
    "response_selector": {
      "apply_now_url": ".wp-block-button a",
      "get_from_content": ".entry-header h1",
      "description_raw_html": ".entry-content"
    }
  },
  "logo": "blue_mountain_hospital.png"
}

MGA_HOME_CARE = {
  "listing_selector": {
    "job-container-list": ".job-listing .joblist",
    "main_selector": {
      "title": ".job-title",
      "source_url": ".job-title a"
    },
    "response_selector": {
      "location": ".job-location"
    }
  },
  "detail_selector": {
    "job_does_not_exist": {
      "not_found_container": ".w-iconbox-meta .w-iconbox-text",
      "not_found_text": "The link you followed may be broken, or the page may have been removed."
    },
    "job-detail-container": ".job-content .cl-left",
    "response_selector": {
      "job_type": ".job-type",
      "apply_now_url": ".w-btn-wrapper a",
      "shift_type": ".company-description ul[1] li[4]",
      "get_from_content": ".job-sections .company-description",
      "description_raw_html": ".job-sections .company-description"
    }
  },
  "logo": "mga_home_care.png"
}

CVS_HEALTH = {
  "listing_selector": {
    "job-container-list": "#widget-jobsearch-results-list .job",
    "main_selector": {
      "title": ".jobTitle a",
      "source_url": ".jobTitle a"
    },
    "pagination": {
      "next_button": "#widget-jobsearch-results-pages .pagination-li a:not([disabled]",
      next_button_text: ">>"
    },
    "response_selector": {
      "location": ".joblist-location .job-locale",
      "job_refernce_id": ".job-innerwrap.g-cols div[3]"
    }
  },
  "detail_selector": {
    "job_does_not_exist": {
      "not_found_container": ".post-content .fusion-layout-column.fusion_builder_column.fusion-builder-column-3"
    },
    "job-detail-container": ".post-content .fusion-layout-column.fusion_builder_column.fusion-builder-column-5",
    "response_selector": {
      "apply_now_url": ".fusion-text.fusion-text-2 a.apply-btn",
      "get_from_content": ".fusion-text.fusion-text-3",
      "description_raw_html": ".fusion-text.fusion-text-3"
    }
  },
  "logo": "cvs_health.png"
}

ATLAS_HEALTH = {
  "listing_selector": {
    "job-container-list": "#jobsect .pfc-jl .entry-categories",
    "main_selector": {
      "title": ".joblinks",
      "source_url": ".joblinks"
    },
    "pagination": {
      "next_button": ".pagination .facetwp-pager a:not([disabled]",
      next_button_text: ">>"
    },
    "response_selector": {
      "location": ".joblinks .loc-stuff",
    }
  },
  "detail_selector": {
    "job_does_not_exist": {
      "not_found_container": ".error404-content .entry-title",
      "not_found_text": "PAGE NOT FOUND"
    },
    "job-detail-container": ".job-desc",
    "response_selector": {
      "apply_now_url": ".applyjd",
      "get_from_content": ".oculusStuff",
      "description_raw_html": ".oculusStuff"
    }
  },
  "logo": "atlas_health.png"
}

AZ_STATE = {
  "listing_selector": {
    "job-container-list": ".job-search-results-table tbody tr",
    "main_selector": {
      "title": ".job-search-results-title a",
      "source_url": ".job-search-results-title a"
    },
    "cookies_modal": {
      "id": ".modal-content #consent_agree",
      "button_text": "I accept"
    },
    "pagination": {
      "next_button": ".pagination-container .text-right .next_page:not([class='next next_page disabled page-item'])",
      next_button_text: "›"
    },
    "response_selector": {
      "job_refernce_id": ".job-search-results-requisition-identifiers",
      "job_type": ".job-search-results-employment-type",
      "location": ".job-search-results-location li[1]",
      "remote_type": ".job-search-results-location li[2]"
    }
  },
  "detail_selector": {
    "job_does_not_exist": {
      "not_found_container": ".error404-content .entry-title",
      "not_found_text": "PAGE NOT FOUND"
    },
    "job-detail-container": ".block-job-description",
    "response_selector": {
      "apply_now_url": ".applyjd",
      "department": ".job-component-list-department",
      "get_from_content": ".job-description",
      "description_raw_html": ".job-description"
    }
  },
  "logo": "az_state.png"
}

ADELANTE_HEALTH_CARE = {
  "listing_selector": {
    "job-container-list": ".jobs-list .py-20.py-md-30.border-top",
    "main_selector": {
      "title": ".job-excerpt h3",
      "source_url": ".job-excerpt"
    },
    "pagination": {
      "next_button": ".wp-pagenavi .nextpostslink",
      next_button_text: "Next"
    },
    "response_selector": {
      "job_type": ".job-excerpt .font-weight-semibold"
    }
  },
  "detail_selector": {
    "job_does_not_exist": {
      "not_found_container": "body div",
      "not_found_text": "Job board does not exist or is unavailable at this time."
    },
    "job-detail-container": "#main-content .col-md-8",
    "response_selector": {
      "location": ".cardContainer span[aria-label='Job Location']",
      "job_type": ".cardContainer .local_left .div[2]",
      "category": ".cardContainer .local_right .div[1]",
      "apply_now_url": ".applyjd",
      "get_from_content": ".cardContainer",
      "description_raw_html": ".cardContainer"
    }
  },
  "logo": "adelante-health.png"
}

HOSPICE_OF_THE_VALLEY = {
  "listing_selector": {
    "job-container-list": "#listings .job-listing.card",
    "main_selector": {
      "title": "a span",
      "source_url": "a"
    },
    "response_selector": {
      "job_type": ".h4.margin-top-none .field-column.col-md-6.col-xs-12",
      "location": ".h4.margin-top-none .field-column.col-md-3.col-xs-12"
    }
  },
  "detail_selector": {
    "job_does_not_exist": {
      "not_found_container": ".card-body",
      "not_found_text": "This job posting is no longer available."
    },
    "job-detail-container": ".card-body",
    "response_selector": {
      "job_type": ".col-md-12.col-xs-12 div[2] div[2] span span",
      "category": ".col-md-12.col-xs-12 div[2] div[3] span span",
      "apply_now_url": ".applyjd",
      "get_from_content": ".col-md-12.col-xs-12",
      "description_raw_html": "span[itemprop='description']"
    }
  },
  "logo": "HOSPICE_OF_THE_VALLEY.jpg"
}

BANNER_HEALTH = {
  "listing_selector": {
    "job-container-list": ".css-8j5iuw ul li.css-1q2dra3",
    "main_selector": {
      "title": "h3",
      "source_url": "a"
    },
    "pagination": {
      "next_button": ".css-3z7fsk .css-19yi5fs button[data-uxi-element-id='next']"
    },
    "response_selector": {
      "location": ".css-248241 .css-k008qs dl dd.css-129m7dg"
    }
  },
  "detail_selector": {
    "job_does_not_exist": {
      "not_found_container": "body div",
      "not_found_text": "Job board does not exist or is unavailable at this time."
    },
    "job-detail-container": ".css-e23il0",
    "response_selector": {
      "job_type": ".css-ey7qxc .css-k008qs dl .css-129m7dg",
      "get_from_content": ".css-11p01j8",
      "description_raw_html": ".css-ey7qxc"
    }
  },
  "logo": "banner-health.png"
}

TENET_HEALTH = {
  "listing_selector": {
    "job-container-list": "#search-results-list>ul li",
    "main_selector": {
      "title": "a h2",
      "source_url": "a"
    },
    "cookies_modal": {
      "id": "#gdpr-alert #gdpr-button",
      "button_text": "Accept"
    },
    "pagination": {
      "next_button": ".pagination-paging a.next:not([class='next disabled'])"
    },
    "response_selector": {
      "location": "a span.job-location"
    }
  },
  "detail_selector": {
    "cookies_modal": {
      "id": "#gdpr-alert #gdpr-button",
      "button_text": "Accept"
    },
    "job_does_not_exist": {
      "not_found_container": ".content h1",
      "not_found_text": "Job Error"
    },
    "job-detail-container": ".ajd-content .ajd",
    "response_selector": {
      "apply_now_url": ".ajd_btn__apply.ajd-button.job-apply.top",
      "get_from_content": "#anchor-responsibilties",
      "description_raw_html": "#anchor-responsibilties"
    }
  },
  "logo": "tenet-health.png"
}
