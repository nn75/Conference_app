//
//  IntroductionViewController.swift
//  HFTP
//
//  Created by Nan Ni on 4/10/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var introductionText: UILabel!
    @IBOutlet weak var introductionTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make scrollView resizable
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: introductionText.bottomAnchor).isActive = true
        
        self.navigationItem.title = K.titles.introTitle
        
        introductionTitle.text = "HFTP Mid-south Atlantic Regional Conference History"
        introductionText.text = """
        Welcome to the 14th HFTP Mid-south Atlantic Regional Conference!
        
        The HFTP Mid-South Atlantic Regional Conference is an effort to bring together hospitality professionals in the regin for continuing professional education, networking and fellowship.
        
        The HFTP Mid-South Atlantic Regional Conference began with a toast and an idea in 2006. The Sandhills Seminar had been hosted by the HFTP Central Carolina Chapter for several years. In August, 2006 the seminar had completed its usual Friday all day seminars, and the attendees and their guests gathered for cocktails and dinner in the dining room of the Carolina Inn in Pinehurst. A toast was offered by the President of the HFTP Charlotte-Blue Ridge Chapter, Steve Argo, thanking the Central Carolina Chapter for hosting the seminar. Steve then offered an idea that his chapter should host a similar seminar in the Blue Ridge, and asked Terry Price if the Grove Park Inn would be able to serve as the host of that seminar.
        
        The seeds were planted and at the HFTP Annual Convention and Trade Show in Vancouver British Columbia in October, a group consisting of Terry Price, Steve Argo, Joann Phillips, Janis Brehm, and Rebecca Walker discussed the possibility at a reception. Terry Price made a phone call to check on an available weekend and came back to the group with the dates—Friday February 8th and Saturday February 9th 2007. The planning began and the group added Mike Womble to the organizing committee chaired by Steve Argo. The final speakers were engaged on December 7, 2006 and the conference was announced to the membership of the two chapters.
        
        The first conference, named the HFTP Blue Ridge Conference, was held with 45 attendees. The conference began at noon on Friday and ended at noon on Saturday. The cost of the registration was $150, which included the conference, lunch, social hour, and dinner on Friday night. The dinner was held at the Inn on Biltmore Estate with 65 attendees and guests. There was only one sponsor who volunteered to do so on the opening day of the conference.
        
        It was decided to hold the two conferences again in 2007-2008 with the Sandhills Seminar held in August of 2007 and the Blue Ridge Conference again held at The Grove Park Inn in February 2008. At that conference R.P. Rama and the HFTP South Carolina chapter asked to host the conference in Charleston in 2009, and it was decided to rotate the conference among Asheville, Pinehurst, and Charleston. At the conference in Charleston, renamed the HFTP Carolinas Conference, the HFTP Central Virginia Chapter asked to be included as part of the rotation beginning in 2011.
        
        After the 2009 Carolinas Conference a survey was sent out to all attendees and members of the four chapters. As part of that survey names were suggested for the new format of the conference and it was decided that the conference would be re-named the HFTP Mid-South Atlantic Regional Conference (MSARC).
        
        In 2014 the sponsoring Chapters formed an Advisory Council to serve the MSARC and act as a resource for the MSARC Host Organizing Committee. The Advisory Council is not responsible for the day-to-day details of a particular MSARC but focuses on setting guidelines, policies and procedures for the Organizing Committee.
        
        The HFTP Mid-South Atlantic Regional Conference was born out of an idea for more opportunities for hospitality professionals to gather together for continuing professional education and time for socializing and getting to know each other better. We sincerely hope that this effort will continue for many years to come.
        """
    }
    
}
