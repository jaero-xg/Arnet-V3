// lib/data/sample_data.dart

import '../models/app_models.dart';

final List<LearningModule> sampleModules = [
  LearningModule(
    id: 'mod_fundamentals',
    title: 'Fundamentals of Data Communication',
    description:
        'Learn the core principles of data communication including transmission modes, protocols, and how data flows between devices across networks.',
    thumbnailEmoji: '🌐',
    completedLessons: 2,
    lessons: [
      Lesson(
        id: 'les_fundamentals_1',
        title: 'Lesson 1',
        subtitle: 'Data Communication Concepts',
        readingTimeMinutes: 5,
        isCompleted: true,
        sections: [
          LessonSection(
            heading: 'What is Communication?',
            body:
                'Communication can be defined as the exchange of information between two or more bodies. In engineering, exchange of information is not only between people, information exchange also takes place between machines or systems.',
          ),
          LessonSection(
            heading: 'What is Data?',
            body:
                'Data is referred to as a piece of information formatted in a special way. Data can exist in a variety of forms, such as numbers or text on pieces of paper, as bits and bytes stored in electronic memory, or as facts stored in a person\'s mind.',
          ),
          LessonSection(
            heading: 'What is Data Communication?',
            body:
                'Data communications are the exchange of data between two devices via some form of transmission medium such as a wire or cable.',
          ),
          LessonSection(
            heading: 'Analog and Digital Signals',
            body:
                'Data communication signals can be classified into two types: analog and digital. Analog signals are continuous waves that vary smoothly over time, while digital signals are discrete and represent data as binary values of 0s and 1s. The choice between analog and digital signals affects the quality, speed, and reliability of data transmission.',
          ),
          LessonSection(
            heading: 'Analog Signal',
            body:
                'An analog signal is a continuous signal that represents physical measurements. It varies smoothly and continuously over time and can take any value within a given range. Examples include sound waves, radio waves, and traditional telephone signals. Analog signals are more susceptible to noise and interference, which can degrade the quality of transmission over long distances.',
          ),
          LessonSection(
            heading: 'Digital Signal',
            body:
                'A digital signal represents data as a sequence of discrete values, typically binary — either 0 or 1. Unlike analog signals, digital signals are less affected by noise and can be transmitted over long distances with greater accuracy. Modern communication systems, including the internet and mobile networks, primarily rely on digital signals due to their reliability and efficiency.',
          ),
          LessonSection(
            heading: 'Components of Data Communication System',
            body:
                'A data communication system consists of five key components:\n'
                '1. Message — the information or data to be transmitted;\n'
                '2. Sender — the device that sends the message, such as a computer or phone; \n'
                '3. Receiver — the device that receives the message; \n'
                '4. Transmission Medium — the physical path through which the message travels, such as cables or wireless channels; and \n'
                '5. Protocol — the set of rules that govern how data is transmitted and received between devices.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'What is anatomy primarily concerned with?',
            options: [
              'The chemical composition of the body',
              'The structure of organisms and their parts',
              'The psychological behavior of living things',
              'The evolutionary history of species',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'Which branch of anatomy uses optical instruments?',
            options: [
              'Gross anatomy',
              'Comparative anatomy',
              'Microscopic anatomy',
              'Applied anatomy',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Anatomy is a branch of which science?',
            options: [
              'Physical science',
              'Natural science',
              'Social science',
              'Computer science',
            ],
            correctIndex: 1,
          ),
        ],
      ),
      Lesson(
        id: 'les_fundamentals_2',
        title: 'Lesson 2',
        subtitle: 'Introduction to Computer Networks',
        readingTimeMinutes: 5,
        isCompleted: true,
        sections: [
          LessonSection(
            heading: 'What is Anatomy?',
            body:
                'Anatomy is the branch of biology concerned with the study of the structure of organisms and their parts. It is a branch of natural science dealing with the structural organization of living things.',
          ),
          LessonSection(
            heading: 'Branches of Anatomy',
            body:
                'Gross anatomy involves the study of major body structures by dissection and observation. Microscopic anatomy involves the use of optical instruments in the study of smaller structures.',
          ),
          LessonSection(
            heading: 'Importance of Anatomy',
            body:
                'Understanding anatomy is fundamental to the practice of health and medicine. It provides the foundation for understanding how the body functions in both health and disease.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'What is anatomy primarily concerned with?',
            options: [
              'The chemical composition of the body',
              'The structure of organisms and their parts',
              'The psychological behavior of living things',
              'The evolutionary history of species',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'Which branch of anatomy uses optical instruments?',
            options: [
              'Gross anatomy',
              'Comparative anatomy',
              'Microscopic anatomy',
              'Applied anatomy',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Anatomy is a branch of which science?',
            options: [
              'Physical science',
              'Natural science',
              'Social science',
              'Computer science',
            ],
            correctIndex: 1,
          ),
        ],
      ),
      Lesson(
        id: 'les_fundamentals_3',
        title: 'Lesson 3',
        subtitle: 'Computer Network Models',
        readingTimeMinutes: 8,
        isCompleted: false,
        sections: [
          LessonSection(
            heading: 'Organ Systems',
            body:
                'The human body consists of many organ systems that work together. Major systems include the skeletal, muscular, circulatory, respiratory, digestive, nervous, and endocrine systems.',
          ),
          LessonSection(
            heading: 'The Skeletal System',
            body:
                'The adult human skeleton consists of 206 bones. It provides structure, protects organs, enables movement, and produces blood cells in the bone marrow.',
          ),
          LessonSection(
            heading: 'The Circulatory System',
            body:
                'The circulatory system consists of the heart, blood, and blood vessels. It transports nutrients, oxygen, and hormones throughout the body while removing waste products.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'How many bones are in the adult human skeleton?',
            options: ['186', '196', '206', '216'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Which system transports nutrients and oxygen?',
            options: ['Skeletal', 'Muscular', 'Circulatory', 'Digestive'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Where are blood cells produced?',
            options: ['Heart', 'Liver', 'Bone marrow', 'Kidneys'],
            correctIndex: 2,
          ),
        ],
      ),
    ],
  ),
  LearningModule(
    id: 'mod_transmission',
    title: 'Data Transmission',
    description:
        'Explore how data is transmitted across networks through various media, signals, and encoding techniques including wired and wireless methods.',
    thumbnailEmoji: '📤',
    completedLessons: 2,
    lessons: [
      Lesson(
        id: 'les_transmission_1',
        title: 'Lesson 1',
        subtitle: 'Transmission Modes',
        readingTimeMinutes: 5,
        isCompleted: true,
        sections: [
          LessonSection(
            heading: 'What is Anatomy?',
            body:
                'Anatomy is the branch of biology concerned with the study of the structure of organisms and their parts. It is a branch of natural science dealing with the structural organization of living things.',
          ),
          LessonSection(
            heading: 'Branches of Anatomy',
            body:
                'Gross anatomy involves the study of major body structures by dissection and observation. Microscopic anatomy involves the use of optical instruments in the study of smaller structures.',
          ),
          LessonSection(
            heading: 'Importance of Anatomy',
            body:
                'Understanding anatomy is fundamental to the practice of health and medicine. It provides the foundation for understanding how the body functions in both health and disease.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'What is anatomy primarily concerned with?',
            options: [
              'The chemical composition of the body',
              'The structure of organisms and their parts',
              'The psychological behavior of living things',
              'The evolutionary history of species',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'Which branch of anatomy uses optical instruments?',
            options: [
              'Gross anatomy',
              'Comparative anatomy',
              'Microscopic anatomy',
              'Applied anatomy',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Anatomy is a branch of which science?',
            options: [
              'Physical science',
              'Natural science',
              'Social science',
              'Computer science',
            ],
            correctIndex: 1,
          ),
        ],
      ),
      Lesson(
        id: 'les_transmission_2',
        title: 'Lesson 2',
        subtitle: 'Transmission Media',
        readingTimeMinutes: 8,
        isCompleted: true,
        sections: [
          LessonSection(
            heading: 'Organ Systems',
            body:
                'The human body consists of many organ systems that work together. Major systems include the skeletal, muscular, circulatory, respiratory, digestive, nervous, and endocrine systems.',
          ),
          LessonSection(
            heading: 'The Skeletal System',
            body:
                'The adult human skeleton consists of 206 bones. It provides structure, protects organs, enables movement, and produces blood cells in the bone marrow.',
          ),
          LessonSection(
            heading: 'The Circulatory System',
            body:
                'The circulatory system consists of the heart, blood, and blood vessels. It transports nutrients, oxygen, and hormones throughout the body while removing waste products.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'How many bones are in the adult human skeleton?',
            options: ['186', '196', '206', '216'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Which system transports nutrients and oxygen?',
            options: ['Skeletal', 'Muscular', 'Circulatory', 'Digestive'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Where are blood cells produced?',
            options: ['Heart', 'Liver', 'Bone marrow', 'Kidneys'],
            correctIndex: 2,
          ),
        ],
      ),
      Lesson(
        id: 'les_transmission_3',
        title: 'Lesson 3',
        subtitle: 'Multiplexing and Switching',
        readingTimeMinutes: 6,
        isCompleted: false,
        sections: [
          LessonSection(
            heading: 'Clinical Anatomy',
            body:
                'Clinical anatomy applies anatomical knowledge to medical diagnosis and treatment. Understanding normal anatomy helps clinicians identify abnormalities.',
          ),
          LessonSection(
            heading: 'Medical Imaging',
            body:
                'Modern medical imaging techniques such as X-ray, CT scan, and MRI allow visualization of internal structures without surgery, making anatomical knowledge essential for interpretation.',
          ),
          LessonSection(
            heading: 'Surgical Anatomy',
            body:
                'Surgeons must have detailed knowledge of anatomy to perform procedures safely. Understanding the relationships between structures helps avoid damage to vital nerves and vessels.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'What does clinical anatomy primarily focus on?',
            options: [
              'Historical anatomy',
              'Medical diagnosis and treatment',
              'Animal anatomy',
              'Evolutionary studies',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'Which imaging technique does NOT use radiation?',
            options: ['X-ray', 'CT scan', 'MRI', 'PET scan'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Why is anatomical knowledge important in surgery?',
            options: [
              'To reduce surgery time',
              'To avoid damage to vital structures',
              'To improve anesthesia',
              'To reduce costs',
            ],
            correctIndex: 1,
          ),
        ],
      ),
    ],
  ),
  LearningModule(
    id: 'mod_implementation',
    title: 'Network Implementation Devices',
    description:
        'Discover the roles and functions of key networking hardware such as routers, switches, hubs, and access points in building a network.',
    thumbnailEmoji: '🔌',
    completedLessons: 1,
    lessons: [
      Lesson(
        id: 'les_implementation_1',
        title: 'Lesson 1',
        subtitle: "Network Devices",
        readingTimeMinutes: 7,
        isCompleted: true,
        sections: [
          LessonSection(
            heading: 'First Law: Inertia',
            body:
                'An object at rest stays at rest, and an object in motion stays in motion with the same speed and in the same direction unless acted upon by an unbalanced force.',
          ),
          LessonSection(
            heading: 'Second Law: F = ma',
            body:
                'The acceleration of an object depends on the net force acting on the object and the mass of the object. Force equals mass times acceleration.',
          ),
          LessonSection(
            heading: 'Third Law: Action-Reaction',
            body:
                'For every action, there is an equal and opposite reaction. Forces always come in pairs that are equal in strength and opposite in direction.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: "Newton's First Law describes which property?",
            options: ['Gravity', 'Inertia', 'Momentum', 'Energy'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'What does F = ma represent?',
            options: [
              'First law',
              'Second law',
              'Third law',
              'Law of gravity',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'The Third Law states forces come in:',
            options: [
              'Triplets',
              'Groups of four',
              'Equal and opposite pairs',
              'Multiples of mass',
            ],
            correctIndex: 2,
          ),
        ],
      ),
      Lesson(
        id: 'les_implementation_2',
        title: 'Lesson 2',
        subtitle: 'IP Addressing',
        readingTimeMinutes: 5,
        isCompleted: false,
        sections: [
          LessonSection(
            heading: 'Universal Gravitation',
            body:
                'Every mass attracts every other mass in the universe with a force that is directly proportional to the product of their masses and inversely proportional to the square of the distance between them.',
          ),
          LessonSection(
            heading: 'Weight vs Mass',
            body:
                'Mass is the amount of matter in an object, measured in kilograms. Weight is the gravitational force acting on that mass, measured in Newtons. Weight = mass × gravitational acceleration.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'Weight is measured in which unit?',
            options: ['Kilograms', 'Grams', 'Newtons', 'Joules'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Mass is the amount of _____ in an object.',
            options: ['Weight', 'Matter', 'Energy', 'Force'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'Gravitational force is inversely proportional to:',
            options: [
              'Mass',
              'Velocity',
              'Square of distance',
              'Temperature',
            ],
            correctIndex: 2,
          ),
        ],
      ),
      Lesson(
        id: 'les_implementation_3',
        title: 'Lesson 3',
        subtitle: 'Subnetting',
        readingTimeMinutes: 6,
        isCompleted: false,
        sections: [
          LessonSection(
            heading: 'What is Energy?',
            body:
                'Energy is the capacity to do work. It exists in many forms including kinetic energy (energy of motion), potential energy (stored energy), thermal energy, and electromagnetic energy.',
          ),
          LessonSection(
            heading: 'Work-Energy Theorem',
            body:
                'Work is done when a force causes displacement of an object. The work done on an object equals the change in its kinetic energy. Work = Force × Distance × cos(θ).',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'Energy is the capacity to do:',
            options: ['Force', 'Work', 'Motion', 'Power'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'Kinetic energy is the energy of:',
            options: ['Position', 'Heat', 'Motion', 'Light'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Work requires both force and:',
            options: ['Mass', 'Time', 'Displacement', 'Velocity'],
            correctIndex: 2,
          ),
        ],
      ),
    ],
  ),
  LearningModule(
    id: 'mod_setup',
    title: 'Network Setup & Configuration',
    description:
        'Learn how to plan, set up, and configure a network from scratch including IP addressing, subnetting, and basic network troubleshooting.',
    thumbnailEmoji: '⚙️',
    completedLessons: 0,
    lessons: [
      Lesson(
        id: 'les_setup_1',
        title: 'Lesson 1',
        subtitle: 'Building Home Network',
        readingTimeMinutes: 6,
        isCompleted: false,
        sections: [
          LessonSection(
            heading: 'The Cell: Basic Unit of Life',
            body:
                'Cells are the smallest structural and functional units of all living organisms. Every living thing is made of one or more cells, and all cells arise from pre-existing cells.',
          ),
          LessonSection(
            heading: 'Cell Organelles',
            body:
                'The nucleus contains genetic material. Mitochondria produce energy. The endoplasmic reticulum synthesizes proteins and lipids. The Golgi apparatus modifies and packages proteins for transport.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'What is the smallest unit of life?',
            options: ['Tissue', 'Organ', 'Cell', 'Molecule'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Which organelle produces energy?',
            options: ['Nucleus', 'Mitochondria', 'Golgi apparatus', 'Ribosome'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'Where is genetic material stored?',
            options: ['Mitochondria', 'Cell membrane', 'Nucleus', 'Vacuole'],
            correctIndex: 2,
          ),
        ],
      ),
      Lesson(
        id: 'les_setup_2',
        title: 'Lesson 2',
        subtitle: 'Physical Network Setup and Configuration of IP Address',
        readingTimeMinutes: 7,
        isCompleted: false,
        sections: [
          LessonSection(
            heading: 'Mitosis',
            body:
                'Mitosis is a type of cell division resulting in two daughter cells each having the same number and kind of chromosomes as the parent cell. It is used for growth and repair.',
          ),
          LessonSection(
            heading: 'Meiosis',
            body:
                'Meiosis is a type of cell division that results in four daughter cells each with half the number of chromosomes of the parent cell. It is used for sexual reproduction.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'How many daughter cells does mitosis produce?',
            options: ['One', 'Two', 'Three', 'Four'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'Meiosis is used for:',
            options: ['Growth', 'Repair', 'Sexual reproduction', 'Digestion'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Meiosis produces cells with _____ chromosomes.',
            options: ['Double', 'The same', 'Half', 'Triple'],
            correctIndex: 2,
          ),
        ],
      ),
    ],
  ),
];

final List<Model3D> sampleModels = [
  Model3D(
    id: 'mdl_heart',
    name: 'Human Heart',
    description:
        'A detailed 3D model of the human heart showing all four chambers, major vessels, and valve structures.',
    category: 'Anatomy',
    learningObjective: 'Understand cardiac structure and blood flow pathways.',
    relatedModuleId: 'mod_anatomy',
    thumbnailEmoji: '🫀',
  ),
  Model3D(
    id: 'mdl_skeleton',
    name: 'Human Skeleton',
    description:
        'Complete skeletal system with labeled bones, joints, and articulations for anatomical study.',
    category: 'Anatomy',
    learningObjective:
        'Identify major bones and understand skeletal structure.',
    relatedModuleId: 'mod_anatomy',
    thumbnailEmoji: '🦴',
  ),
  Model3D(
    id: 'mdl_atom',
    name: 'Atomic Structure',
    description:
        'Interactive 3D representation of atomic structure including nucleus, electron shells and orbitals.',
    category: 'Physics',
    learningObjective:
        'Visualize atomic components and electron configuration.',
    relatedModuleId: 'mod_physics',
    thumbnailEmoji: '⚛️',
  ),
  Model3D(
    id: 'mdl_cell',
    name: 'Animal Cell',
    description:
        'Detailed 3D model of an animal cell with labeled organelles including nucleus, mitochondria and more.',
    category: 'Biology',
    learningObjective:
        'Identify and understand the function of cell organelles.',
    relatedModuleId: 'mod_cells',
    thumbnailEmoji: '🔬',
  ),
  Model3D(
    id: 'mdl_brain',
    name: 'Human Brain',
    description:
        'Comprehensive model of the human brain showing lobes, major regions, and neural pathways.',
    category: 'Anatomy',
    learningObjective: 'Explore brain regions and their associated functions.',
    relatedModuleId: 'mod_anatomy',
    thumbnailEmoji: '🧠',
  ),
  Model3D(
    id: 'mdl_dna',
    name: 'DNA Double Helix',
    description:
        'Molecular model of DNA double helix structure with base pair visualization.',
    category: 'Biology',
    learningObjective: 'Understand DNA structure and nucleotide base pairing.',
    relatedModuleId: 'mod_cells',
    thumbnailEmoji: '🧬',
  ),
];
