// lib/data/sample_data.dart

import '../models/app_models.dart';

final List<LearningModule> sampleModules = [
  LearningModule(
    id: 'mod_fundamentals',
    title: 'Fundamentals of Data Communication',
    description:
        'Learn the core principles of data communication including transmission modes, protocols, and how data flows between devices across networks.',
    thumbnailEmoji: '🌐',
    completedLessons: 0,
    lessons: [
      Lesson(
        id: 'les_fundamentals_1',
        title: 'Lesson 1',
        subtitle: 'Data Communication Concepts',
        readingTimeMinutes: 5,
        isCompleted: false,
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
            question:
                'Data communication is defined as the exchange of data between two devices through what kind of pathway?',
            options: [
              'Transmission medium',
              'Electronic memory',
              'Encryption layer',
              'Signal converter',
            ],
            correctIndex: 0,
          ),
          QuizQuestion(
            question:
                'Among the core components of a data communication system, which of the following does NOT belong to that list?',
            options: [
              'Sender',
              'Protocol',
              'Operating System',
              'Transmission Medium',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'In data communication, what term refers to the set of rules that govern and regulate how data is transmitted between two or more devices?',
            options: [
              'Physical cable',
              'Analog signal',
              'Protocol',
              'Sender device',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'When a signal varies in a continuous and smooth manner over a period of time rather than switching between fixed values, what type of signal is it?',
            options: [
              'Digital',
              'Analog',
              'Binary',
              'Discrete',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Unlike analog signals, digital signals represent all data and information using only two possible values. What are those values?',
            options: [
              'Continuous waves',
              'Sound frequencies',
              'Radio waves',
              '0s and 1s',
            ],
            correctIndex: 3,
          ),
          QuizQuestion(
            question:
                'Which of the following real-world phenomena is a naturally occurring example of an analog signal due to its continuous and varying nature?',
            options: [
              'Binary code',
              'Data packets',
              'Sound waves',
              'Digital images',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'In a data communication system, the device or component that accepts and processes the message sent by the sender is referred to as what?',
            options: [
              'Sender',
              'Protocol',
              'Receiver',
              'Converter',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'Which specific component of a data communication system refers to the actual information or content that needs to be transmitted from one point to another?',
            options: [
              'Protocol',
              'Sender',
              'Message',
              'Medium',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'In modern communication systems, digital signals are generally preferred over analog signals for which primary technical reason?',
            options: [
              'More colorful',
              'Less noise-affected',
              'No medium needed',
              'Slower but accurate',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'The physical or wireless path through which data travels from the sender to the receiver in a communication system is best described as which component?',
            options: [
              'Protocol',
              'Receiver',
              'Message',
              'Transmission medium',
            ],
            correctIndex: 3,
          ),
        ],
      ),
      Lesson(
        id: 'les_fundamentals_2',
        title: 'Lesson 2',
        subtitle: 'Introduction to Computer Networks',
        readingTimeMinutes: 5,
        isCompleted: false,
        sections: [
          LessonSection(
            heading: 'What is a Computer network?',
            body:
                'Computer network is interconnectivity of two or more computer system for purpose of sharing data. A computer network is a communication system much like a telephone system, any connected device can use the network to send and receive information. In essence a computer network consists of two or more computers connected to each other so that they can share resources.',
          ),
          LessonSection(
            heading: 'What is a Syntax?',
            body:
                'The term syntax refers to the structure or format of the data, meaning the order in which they are presented. ',
          ),
          LessonSection(
            heading: 'What is Semantics?',
            body:
                'The word semantics refers to the meaning of each section of bits. How is a particular pattern to be interpreted and what action is to be taken based on that interpretation.',
          ),
          LessonSection(
            heading: 'What is Timing?',
            body:
                'It refers to two characteristics: when data should be sent and how fast they can be sent. ',
          ),
          LessonSection(
            heading: 'TYPES OF NETWORK',
            body:
                'A network type is defined by its geographical range and the number of devices it connects. The most common types of networks are PAN, LAN, MAN, and WAN, each serving different scales of connectivity — from personal devices to global infrastructure.',
          ),
          LessonSection(
            heading: 'Personal Area Network (PAN)',
            body:
                'A Personal Area Network is the smallest type of network, designed for personal use within a range of a few meters. It connects devices such as smartphones, tablets, laptops, and wireless headsets belonging to a single user. PANs can be wired (e.g., USB) or wireless (e.g., Bluetooth, infrared).',
          ),
          LessonSection(
            heading: 'Local Area Network (LAN)',
            body:
                'A Local Area Network connects computers and devices within a limited geographical area such as a home, school, office building, or campus. LANs are typically owned and managed by a single organization. They offer high data transfer speeds and are commonly implemented using Ethernet cables or Wi-Fi.',
          ),
          LessonSection(
            heading: 'Metropolitan Area Network (MAN)',
            body:
                'A Metropolitan Area Network spans a city or a large campus, covering a geographical area larger than a LAN but smaller than a WAN. MANs are typically used by city governments, universities, or large corporations to connect multiple buildings or branches within a metropolitan region.',
          ),
          LessonSection(
            heading: 'Wide Area Network (WAN)',
            body:
                'A Wide Area Network covers a broad geographical area, often spanning countries or continents. WANs connect multiple LANs and MANs together and are used by large organizations and internet service providers. The Internet is the largest example of a WAN, using a combination of fiber optic cables, satellites, and other transmission technologies.',
          ),
          LessonSection(
            heading: 'NETWORK TOPOLOGIES',
            body:
                'Network topology refers to the arrangement or layout of the various elements (links, nodes, etc.) of a computer network. It defines how different nodes in a network are connected to each other and how they communicate. Topology can be described physically (actual layout of cables) or logically (how data flows).',
          ),
          LessonSection(
            heading: 'Bus Topology',
            body:
                'In a bus topology, all devices are connected to a single central cable called the bus or backbone. Data transmitted by any device travels along the bus and is received by all other devices, but only the intended recipient processes it. It is easy to install but a failure in the main cable brings down the entire network.',
          ),
          LessonSection(
            heading: 'Ring Topology',
            body:
                'In a ring topology, each device is connected to exactly two other devices, forming a circular data path. Data travels in one direction (or both in a dual ring) around the ring until it reaches its destination. A failure in any single cable or device can disrupt the entire network unless a dual-ring configuration is used.',
          ),
          LessonSection(
            heading: 'Star Topology',
            body:
                'In a star topology, all devices are connected to a central hub or switch. All data passes through the central device before reaching its destination. It is the most commonly used topology in modern networks. If one connection fails, only that device is affected, making it more fault-tolerant than bus or ring topologies.',
          ),
          LessonSection(
            heading: 'Mesh Topology',
            body:
                'In a mesh topology, every device is connected to every other device in the network. This provides multiple paths for data transmission, ensuring high reliability and fault tolerance. If one link fails, data can be rerouted through another path. Mesh topologies are expensive to implement but are used in critical networks that require maximum uptime.',
          ),
          LessonSection(
            heading: 'Hybrid Topology',
            body:
                'A hybrid topology is a combination of two or more different topologies, such as a star-bus or star-ring configuration. It is designed to leverage the strengths of each individual topology while minimizing their weaknesses. Hybrid topologies are commonly found in large organizations where different departments may use different network layouts.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question:
                'A computer network is best described as an interconnection of two or more computer systems for the primary purpose of what?',
            options: [
              'Sharing data',
              'Playing games',
              'Storing files',
              'Running programs',
            ],
            correctIndex: 0,
          ),
          QuizQuestion(
            question:
                'In data communication, the term that refers to the structure or format of data and the order in which it is presented is called what?',
            options: [
              'Timing',
              'Semantics',
              'Syntax',
              'Protocol',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'Which characteristic of data communication refers to the meaning of each section of bits and what action should be taken based on their interpretation?',
            options: [
              'Syntax',
              'Timing',
              'Semantics',
              'Encoding',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'Timing in data communication refers to two characteristics: when data should be sent and what other factor?',
            options: [
              'Where it is sent',
              'How fast it can be sent',
              'Who receives it',
              'Why it is transmitted',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Which type of network is the smallest in range and is typically used to connect personal devices like smartphones and laptops belonging to a single user?',
            options: [
              'LAN',
              'WAN',
              'MAN',
              'PAN',
            ],
            correctIndex: 3,
          ),
          QuizQuestion(
            question:
                'A network that connects computers and devices within a limited area such as a school, home, or office building and is commonly implemented using Ethernet or Wi-Fi is called what?',
            options: [
              'WAN',
              'MAN',
              'LAN',
              'PAN',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'Which type of network spans a city or large campus and is typically used to connect multiple buildings or branches within a metropolitan region?',
            options: [
              'PAN',
              'MAN',
              'LAN',
              'WAN',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'The Internet is considered the largest example of which type of network that connects multiple LANs and MANs across countries or continents?',
            options: [
              'PAN',
              'LAN',
              'MAN',
              'WAN',
            ],
            correctIndex: 3,
          ),
          QuizQuestion(
            question:
                'In which network topology are all devices connected to a single central cable called the backbone, where a failure in that cable brings down the entire network?',
            options: [
              'Star topology',
              'Ring topology',
              'Bus topology',
              'Mesh topology',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'Which network topology connects every device to every other device, providing multiple data paths and high fault tolerance at the cost of expensive implementation?',
            options: [
              'Hybrid topology',
              'Star topology',
              'Bus topology',
              'Mesh topology',
            ],
            correctIndex: 3,
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
            heading: 'What is a Network Model?',
            body:
                'Network models define a set of network layers and how they interact. There are several different network models depending on what organization or company started them.',
          ),
          LessonSection(
            heading: 'NETWORK MODEL LAYERS',
            body:
                'Network model layers are a structured way of organizing the functions and protocols involved in data communication. Each layer has a specific role and communicates with the layers directly above and below it. This layered approach simplifies network design by breaking complex communication tasks into smaller, manageable functions. The two most widely recognized network models are the OSI model and the TCP/IP model.',
          ),
          LessonSection(
            heading: 'OSI Layer',
            body:
                'The Open Systems Interconnection (OSI) model is a conceptual framework developed by the International Organization for Standardization (ISO) that standardizes the functions of a communication system into seven distinct layers.\n\n1. Physical – Transmits raw bits over a physical medium such as cables or radio waves.\n2. Data Link – Handles error detection and frames data for transmission between directly connected nodes.\n3. Network – Manages logical addressing and routing of data packets across networks using protocols like IP.\n4. Transport – Ensures reliable end-to-end data delivery and flow control using protocols like TCP and UDP.\n5. Session – Establishes, manages, and terminates communication sessions between applications.\n6. Presentation – Translates, encrypts, and compresses data into a format the application layer can use.\n7. Application – Provides network services directly to end-user applications such as HTTP, FTP, and DNS.\n\nThe OSI model is widely used as a reference guide for understanding and troubleshooting network communication.',
          ),
          LessonSection(
            heading: 'TCP/IP Layer',
            body:
                'The TCP/IP model, also known as the Internet model, is a practical and widely implemented network model that forms the foundation of the modern internet. It consists of four layers:\n\n1. Network Access (Link) – Handles the physical transmission of data over a network medium, combining the functions of the OSI Physical and Data Link layers.\n2. Internet – Manages logical addressing and routing of data packets across multiple networks using the Internet Protocol (IP).\n3. Transport – Ensures reliable or fast data delivery between hosts using TCP (reliable) or UDP (faster, connectionless).\n4. Application – Supports high-level protocols and services used by end-user applications, including HTTP, FTP, SMTP, and DNS.\n\nCompared to the OSI model, TCP/IP is simpler and more directly tied to real-world networking protocols and the structure of the internet.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question:
                'A network model that defines a set of layers and how they interact with each other was developed by which type of entity?',
            options: [
              'A company or organization',
              'A single programmer',
              'A government',
              'A hardware vendor'
            ],
            correctIndex: 0,
          ),
          QuizQuestion(
            question:
                'The OSI model was developed as a conceptual framework by which international standardization body?',
            options: ['IEEE', 'ISO', 'IETF', 'ITU'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'How many distinct layers make up the Open Systems Interconnection (OSI) model used as a reference for network communication?',
            options: ['4', '5', '6', '7'],
            correctIndex: 3,
          ),
          QuizQuestion(
            question:
                'In the OSI model, which layer is responsible for transmitting raw bits over a physical medium such as cables or radio waves?',
            options: ['Data Link', 'Network', 'Physical', 'Transport'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'Which layer of the OSI model is responsible for logical addressing and routing of data packets across different networks?',
            options: ['Transport', 'Network', 'Session', 'Data Link'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'In the OSI model, which layer handles the translation, encryption, and compression of data into a usable format for the application layer?',
            options: ['Session', 'Application', 'Transport', 'Presentation'],
            correctIndex: 3,
          ),
          QuizQuestion(
            question:
                'The TCP/IP model is also commonly referred to by another name that reflects its close relationship with the modern internet. What is that name?',
            options: ['ISO model', 'Internet model', 'OSI model', 'Link model'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'How many layers does the TCP/IP model consist of, making it simpler compared to the OSI model?',
            options: ['3', '4', '5', '6'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'In the TCP/IP model, which layer combines the functions of the OSI Physical and Data Link layers and handles physical data transmission?',
            options: ['Internet', 'Transport', 'Application', 'Network Access'],
            correctIndex: 3,
          ),
          QuizQuestion(
            question:
                'Which layer is present in both the OSI and TCP/IP models and is responsible for supporting high-level protocols such as HTTP, FTP, and DNS?',
            options: ['Transport', 'Network', 'Application', 'Session'],
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
    completedLessons: 0,
    lessons: [
      Lesson(
        id: 'les_transmission_1',
        title: 'Lesson 1',
        subtitle: 'Transmission Modes',
        readingTimeMinutes: 5,
        isCompleted: false,
        sections: [
          LessonSection(
            heading: 'TRANSMISSION MODE',
            body:
                'A transmission may be simplex, half duplex, or full duplex. In simplex transmission signals are transmitted in only one direction; one station is transmitter and the other one is receiver. In half-duplex operation, both stations may transmit, but only one at a time. In full-duplex operation, both stations may transmit simultaneously.',
          ),
          LessonSection(
            heading: 'TYPES OF TRANSMISSION MODE',
            body:
                'Transmission mode refers to the direction of signal flow between two communicating devices. It defines how data travels across a communication link — whether in one direction only, in both directions but not simultaneously, or in both directions at the same time. The three main types of transmission modes are Simplex, Half Duplex, and Full Duplex.',
          ),
          LessonSection(
            heading: 'Simplex Transmission',
            body:
                'In simplex mode, the communication is unidirectional, as on a one-way street. Only one of the two devices on a link can transmit; the other can only receive.',
          ),
          LessonSection(
            heading: 'Simplex Transmission',
            body:
                'Since simplex communication only allows data to flow in one direction, the receiving device has no way to send feedback or acknowledgment back to the sender. Examples of simplex transmission include keyboards sending input to a computer, traditional television broadcasting where the station transmits and viewers only receive, and radio broadcasting. It is best suited for situations where no return communication is needed.',
          ),
          LessonSection(
            heading: 'Half Duplex Transmission',
            body:
                'In half-duplex mode, both devices on a communication link can transmit and receive data, but not at the same time. When one device is sending, the other must wait until the transmission is complete before it can respond. This is similar to a walkie-talkie where only one person can speak at a time. Half-duplex is commonly used in two-way radio communication and older network systems. While it allows bidirectional communication, the alternating nature of transmission can reduce overall efficiency.',
          ),
          LessonSection(
            heading: 'Full Duplex Transmission',
            body:
                'In full-duplex mode, both devices can transmit and receive data simultaneously over the same communication link. This is the most efficient transmission mode as it allows two-way communication without any waiting. A telephone conversation is a classic example of full-duplex communication, where both parties can speak and hear at the same time. Modern network connections, such as Ethernet and cellular networks, also operate in full-duplex mode, significantly improving speed and performance.',
          ),
          LessonSection(
            heading: 'DIGITAL DATA TRANSMISSION METHODS',
            body:
                'Digital data transmission methods define how binary data (0s and 1s) is physically sent from one device to another. The method used affects the speed, cost, and reliability of communication. The main digital transmission methods are Parallel, Serial, Synchronous, Asynchronous, and Isochronous transmission, each suited for different communication needs and distances.',
          ),
          LessonSection(
            heading: 'Parallel Transmission',
            body:
                'In parallel transmission, multiple bits are sent simultaneously over multiple channels or wires. For example, in an 8-bit parallel transmission, 8 bits are sent at the same time using 8 separate wires. This makes parallel transmission significantly faster than serial transmission. However, it is more expensive due to the need for multiple lines and is generally limited to short distances because signals on different wires can become out of sync over longer distances. Parallel transmission is commonly used internally within computers, such as between the CPU and memory.',
          ),
          LessonSection(
            heading: 'Serial Transmission',
            body:
                'In serial transmission, bits are sent one after another in a sequential order over a single channel or wire. Although slower than parallel transmission, serial transmission is more cost-effective and practical for long-distance communication since only one line is required. It is less prone to timing issues that affect parallel transmission over distance. Serial transmission is widely used in modern communication standards such as USB, HDMI, and internet data transfer.',
          ),
          LessonSection(
            heading: 'Synchronous Transmission',
            body:
                'In synchronous transmission, data is sent in a continuous stream of bits grouped into frames or blocks. The sender and receiver are synchronized using a shared clock signal, which allows the receiver to know exactly when each bit begins and ends. This method is highly efficient for transmitting large amounts of data at high speed because there is no need for start and stop bits between individual characters. Synchronous transmission is commonly used in real-time communication systems and high-speed network connections.',
          ),
          LessonSection(
            heading: 'Isochronous Transmission',
            body:
                'Isochronous transmission guarantees that data is delivered at a fixed and consistent rate, ensuring there are no variable delays between transmissions. It combines aspects of both synchronous and asynchronous transmission and is designed specifically for time-sensitive data such as audio and video streams. Because multimedia applications require a steady and predictable flow of data to avoid interruptions, isochronous transmission is ideal for real-time applications like video conferencing, live streaming, and VoIP (Voice over Internet Protocol).',
          ),
          LessonSection(
            heading: 'Asynchronous Transmission',
            body:
                'In asynchronous transmission, data is sent one character or byte at a time, with each unit of data framed by a start bit and one or more stop bits. These bits signal the beginning and end of each character, allowing the sender and receiver to synchronize for each individual transmission without needing a shared clock. This method is simple and flexible, making it ideal for irregular or low-speed communication. Asynchronous transmission is commonly used in keyboard input, serial communication ports, and older modem connections.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question:
                'In which transmission mode is communication strictly unidirectional, where only one device can transmit while the other can only receive?',
            options: ['Half duplex', 'Full duplex', 'Simplex', 'Serial'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'A walkie-talkie is a common real-world example of which transmission mode where both devices can communicate but not at the same time?',
            options: ['Simplex', 'Half duplex', 'Full duplex', 'Parallel'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Which transmission mode allows both devices to send and receive data simultaneously, making it the most efficient of the three modes?',
            options: ['Simplex', 'Isochronous', 'Half duplex', 'Full duplex'],
            correctIndex: 3,
          ),
          QuizQuestion(
            question:
                'Traditional television and radio broadcasting are classic examples of which type of transmission mode since viewers and listeners can only receive signals?',
            options: ['Full duplex', 'Half duplex', 'Simplex', 'Asynchronous'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'In parallel transmission, multiple bits are sent simultaneously over multiple wires, but what is its major limitation that makes it unsuitable for long distances?',
            options: [
              'Too slow',
              'Signal sync issues',
              'High noise',
              'Single wire'
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Which digital transmission method sends bits one after another sequentially over a single channel and is widely used in standards such as USB and HDMI?',
            options: ['Parallel', 'Synchronous', 'Serial', 'Isochronous'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'In synchronous transmission, the sender and receiver are kept in sync through what mechanism that eliminates the need for start and stop bits?',
            options: ['Stop bits', 'Shared clock', 'Start bits', 'Data frames'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Which transmission method wraps each character or byte with a start bit and stop bits to synchronize the sender and receiver for each individual transmission?',
            options: ['Synchronous', 'Isochronous', 'Parallel', 'Asynchronous'],
            correctIndex: 3,
          ),
          QuizQuestion(
            question:
                'Real-time applications such as video conferencing and live audio streaming require which transmission method that guarantees a fixed and consistent data delivery rate?',
            options: ['Asynchronous', 'Serial', 'Isochronous', 'Simplex'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'Which digital transmission method is commonly used within computers, such as between the CPU and memory, due to its ability to send multiple bits at the same time?',
            options: ['Serial', 'Asynchronous', 'Synchronous', 'Parallel'],
            correctIndex: 3,
          ),
        ],
      ),
      Lesson(
        id: 'les_transmission_2',
        title: 'Lesson 2',
        subtitle: 'Transmission Media',
        readingTimeMinutes: 8,
        isCompleted: false,
        sections: [
          LessonSection(
            heading: 'DATA TRANSMISSION MEDIA',
            body:
                'Transmission media is a pathway that carries the information from sender to receiver. We use different types of cables or waves to transmit data. Data is transmitted normally through electrical or electromagnetic signals.\n'
                'Different medias have different properties like bandwidth, delay, cost and ease of installation and maintenance. Transmission media isalso called Communication channel. Transmission media is broadly classified into two groups',
          ),
          LessonSection(
            heading: 'GUIDED TRANSMISSION MEDIADIA',
            body:
                '	These are the cables that are tangible or have physical existence and are limited by the physical geography.',
          ),
          LessonSection(
            heading: 'Twisted Pair',
            body:
                '	A twisted pair consists of two conductors (normally copper), each with its own plastic insulation, twisted together, as shown in Figure 5.3. One of the wires is used to carry signals to the receiver and the other is used only as a ground reference. It is most effectively used in systems that use a balanced line method of transmission',
          ),
          LessonSection(
            heading: 'RJ45 Connector',
            body: 'Connector for twisted pair cable\n'
                'Straight-Through vs. Cross-Over\n'
                'Straight-Through Cable \n'
                'Used to connect a host to a switch or hub, or a router to a switch or hub\n'
                'Cross Over Cable\n'
                'Crossover cables can be used to connect these devices: Switch to switch, Hub to hub, PC to PC',
          ),
          LessonSection(
            heading: 'Coaxial Cable ',
            body:
                '	Coaxial Cable consists of 2 conductors. The inner conductor is held inside an insulator with the other conductor woven around it providing a shield. An insulating protective coating called a jacket covers the outer conductor',
          ),
          LessonSection(
            heading: 'BNC Connectors',
            body: ' Connectors used to connect Coaxial cable',
          ),
          LessonSection(
            heading: 'Optical Fiber',
            body:
                '	Optical fiber is a cable that accepts and transports signals in the form of light. Optical fiber consists of thin glass fiber that can carry information at frequencies in the visible light spectrum.',
          ),
          LessonSection(
            heading: 'Optical Transmission Modes ',
            body: 'Step Index Mode\n'
                'Step Index has a large core the light rays tend to bounce around, reflecting off the cladding, inside the core. This causes some rays to take a longer or shorted path through the core.\n'
                'Grade Index Mode\n'
                'Grade Index has a gradual change in the Core\'s Refractive Index. This causes the light rays to begradually bent back into the core path. \n'
                'Single Mode\n'
                'Single Mode has separate distinct Refractive Indexes for the cladding and core.',
          ),
          LessonSection(
            heading: 'UNGUIDED TRANSMISSION MEDIA',
            body: 'Ground-wave propagation\n'
                'It follows the curvature of the Earth. Ground Waves have carrier frequencies up to 2MHz. AM radio is an example of Ground Wave Propagation\n'
                'Sky-wave propagation\n'
                'Bounces off of the Earths Ionospheric Layer in the upper atmosphere. Because it depends on the Earth\'s ionosphere, it changes with weather and time of day.\n'
                'Line-of-sight propagation\n'
                'It transmits exactly in the line of sight. The receive station must be in the view of the transmit station. It is sometimes called Space Waves or Tropospheric Propagation.\n',
          ),
          LessonSection(
            heading: 'TRANSMISSION MEDIA PROBLEMS AND IMPAIRMENT',
            body: 'Attenuation Distortion\n'
                'Attenuation results in loss of energy. When a signal travels through a medium, it loses some of its energy in overcoming the resistance of the medium.\n'
                'Crosstalk\n'
                'Crosstalk is when one line induces a signal into another line. In voice communications, we often hear this as another conversation going on in the background\n.'
                'Echo or Signal Return\n'
                ' The signal arriving at the end of a transmission line should be fully absorbed otherwise it will be reflected back down the line to the sender and appear as an Echo. Echo Suppressors are often fitted to transmission lines to reduce this effect.\n'
                'Noise\n'
                'Noise is any unwanted signal that is mixed or combined with the original signal during transmission. Due to noise the original signal is altered and signal received is not same as the one sent. Noise is sharp quick spikes on the signal caused from electromagnetic interference, lightning, sudden power switching, electromechanical switching, etc. \n',
          ),
          LessonSection(
            heading: 'CHANNEL CAPACITY',
            body:
                '	The maximum rate at which datacan be transmitted over a given communication path, or channel, under given conditions is referred to as the channel capacity. \n'
                '	There are four concepts here that we are trying to relate to one another\n'
                '- Data rate\n - Bandwidth\n - Noise\n - Error rate',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question:
                'What is the primary purpose of transmission media in a network communication system?',
            options: [
              'Store data',
              'Carry information',
              'Encrypt signals',
              'Filter noise'
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Which type of transmission media is limited by physical geography and has tangible existence?',
            options: ['Unguided', 'Wireless', 'Guided', 'Satellite'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'In a twisted pair cable, what is the purpose of the second wire aside from carrying the signal?',
            options: [
              'Power supply',
              'Ground reference',
              'Signal boost',
              'Noise filter'
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Which cable connector is specifically used for twisted pair cables in network connections?',
            options: ['BNC', 'USB-C', 'RJ45', 'HDMI'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'A crossover cable is needed when connecting which pair of devices together?',
            options: [
              'PC to router',
              'Host to switch',
              'Switch to switch',
              'Router to hub'
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'In optical fiber transmission, which mode has a gradual change in the core\'s Refractive Index that bends light rays back into the core path?',
            options: ['Single Mode', 'Step Index', 'Grade Index', 'Multi Mode'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'Which type of unguided transmission media follows the curvature of the Earth and is used by AM radio?',
            options: ['Sky-wave', 'Line-of-sight', 'Ground-wave', 'Space wave'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'What transmission impairment occurs when a signal loses energy while overcoming the resistance of the medium?',
            options: ['Crosstalk', 'Echo', 'Attenuation', 'Noise'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'When one transmission line induces an unwanted signal into another line, this impairment is known as what?',
            options: ['Attenuation', 'Crosstalk', 'Echo', 'Distortion'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Which four concepts are used to define and relate to channel capacity in a communication system?',
            options: [
              'Speed, Cost, Delay, Power',
              'Data rate, Bandwidth, Noise, Error rate',
              'Frequency, Amplitude, Phase, Power',
              'Latency, Jitter, Loss, Throughput'
            ],
            correctIndex: 1,
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
            heading: 'MULTIPLEXING',
            body:
                'Multiplexing is the set of techniques that allows the simultaneous transmission of multiple signals across a single data link.',
          ),
          LessonSection(
            heading: 'TYPES OF MULTIPLEXING TECHNIQUES',
            body:
                'There are three main types of multiplexing techniques used in data communications:\n'
                '- Frequency Division Multiplexing (FDM)\n'
                '- Time Division Multiplexing (TDM)\n'
                '- Wavelength Division Multiplexing (WDM)\n'
                'Each technique divides the capacity of the transmission medium differently to allow multiple signals to share the same channel simultaneously.',
          ),
          LessonSection(
              heading: 'Frequency Division Multiplexing (FDM)',
              body:
                  'A number of signals are carried simultaneously on the same medium by allocating to each signal a different frequency band.\n'
                  'FDM is an analog technique applied when the bandwidth of a link is greater than the combined bandwidths of the signals to be transmitted. Each signal is modulated to a different carrier frequency, and the carrier frequencies are separated by sufficient bandwidth to prevent overlap. The resulting signals are then combined into a single composite signal for transmission.\n'),
          LessonSection(
            heading: 'Time Division Multiplexing (TDM)',
            body:
                'TDM is applied primarily on digital signals but can be applied on analog signals as well.\n'
                'In TDM, the transmission time of the medium is shared among multiple signals. Instead of sharing a portion of the bandwidth, each signal occupies the entire bandwidth of the channel but only for a short period of time. TDM can be further divided into:\n'
                '- Synchronous TDM: each device is given a fixed time slot regardless of whether it has data to send.\n'
                '- Statistical TDM: time slots are allocated dynamically based on demand, making it more efficient.\n',
          ),
          LessonSection(
              heading: 'SWITCHING',
              body:
                  'Switching is process to forward packets coming in from one port to a port leading towards the destination.\n'
                  'A network is a combination of nodes and links. Switching allows data to be routed from a source to a destination across multiple interconnected nodes. There are two main categories of switching: Connectionless and Connection Oriented.\n'),
          LessonSection(
              heading: 'Connectionless',
              body:
                  'The data is forwarded on behalf of forwarding tables. No previous handshaking is required and acknowledgements are optional.\n'
                  'In connectionless switching, each packet is treated independently and may take a different path to reach the destination. The network does not reserve resources in advance, making it more flexible but potentially less reliable for time-sensitive data.\n'),
          LessonSection(
            heading: 'Connection Oriented',
            body:
                'Before switching data to be forwarded to destination, there is a need to pre-establish circuit along the path between both endpoints. Data is then forwarded on that circuit. After the transfer is completed, circuits can be kept for future use or can be turned down immediately.\n'
                'Connection-oriented switching guarantees a dedicated path and consistent quality of service throughout the duration of the transmission, making it suitable for real-time communications such as voice calls.',
          ),
          LessonSection(
            heading: 'TYPES OF SWITCHING METHODS',
            body:
                'There are three primary methods of switching used in modern networks:\n'
                '- Circuit Switching: a dedicated path is established before transmission begins.\n'
                '- Message Switching: the entire message is stored at each node before being forwarded.\n'
                '- Packet Switching: data is broken into packets that are routed independently across the network.\n'
                'Each method has its own advantages and trade-offs in terms of efficiency, reliability, and delay.',
          ),
          LessonSection(
            heading: 'Circuit Switching',
            body:
                'Circuit switching establishes a dedicated communication path between two stations before any data is transmitted. This path remains reserved for the entire duration of the connection.\n'
                'The process involves three phases: circuit establishment, data transfer, and circuit disconnect. The Public Switched Telephone Network (PSTN) is a classic example of circuit switching. While it guarantees a consistent bandwidth and low latency, resources are wasted when no data is being sent during an active connection.',
          ),
          LessonSection(
            heading: 'Message Switching',
            body:
                'Message switching is a store-and-forward technique where the entire message is sent from the source to an intermediate node, stored temporarily, and then forwarded to the next node until it reaches its destination.\n'
                'Unlike circuit switching, no dedicated path is established. Each node along the route stores the complete message before passing it on. This method is more efficient in bandwidth usage but introduces significant delays, making it unsuitable for real-time communication. Email is a common modern example of message switching.',
          ),
          LessonSection(
            heading: 'Packet Switching',
            body:
                'Packet switching breaks data into smaller units called packets before transmission. Each packet contains the data payload along with header information such as source and destination addresses.\n'
                'Packets may travel different paths across the network and are reassembled at the destination. There are two approaches:\n'
                '- Datagram Packet Switching: each packet is routed independently, similar to connectionless switching.\n'
                '- Virtual Circuit Packet Switching: a logical path is established before transmission, and all packets follow the same route.\n'
                'The Internet primarily uses packet switching due to its efficiency, scalability, and resilience to network failures.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question:
                'What is the primary purpose of multiplexing in data communications?',
            options: [
              'Encrypt signals',
              'Boost signal strength',
              'Transmit multiple signals on one link',
              'Convert analog to digital',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'Which multiplexing technique works by allocating a different frequency band to each signal sharing the same medium?',
            options: [
              'TDM',
              'FDM',
              'WDM',
              'Statistical TDM',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'In Synchronous TDM, what happens to a time slot when a device has no data to send?',
            options: [
              'It is given to another device',
              'It is used for error checking',
              'The slot remains unused',
              'It is compressed',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'Which type of TDM allocates time slots dynamically based on demand, making it more efficient?',
            options: [
              'Synchronous TDM',
              'Frequency TDM',
              'Circuit TDM',
              'Statistical TDM',
            ],
            correctIndex: 3,
          ),
          QuizQuestion(
            question:
                'In connectionless switching, how are packets routed through the network to their destination?',
            options: [
              'Along a pre-established circuit',
              'Each packet is routed independently',
              'Through a dedicated reserved path',
              'Only through a single fixed route',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Which switching method requires a dedicated communication path to be established before any data is transmitted?',
            options: [
              'Packet Switching',
              'Message Switching',
              'Circuit Switching',
              'Statistical Switching',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'What are the three phases involved in circuit switching before a connection is terminated?',
            options: [
              'Request, Transfer, Acknowledge',
              'Connect, Encrypt, Disconnect',
              'Circuit establishment, Data transfer, Circuit disconnect',
              'Handshake, Transmit, Confirm',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'In message switching, what does each intermediate node do before forwarding the data to the next node?',
            options: [
              'Breaks it into packets',
              'Stores the entire message temporarily',
              'Encrypts the message',
              'Compresses the data',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Which packet switching approach establishes a logical path before transmission so all packets follow the same route?',
            options: [
              'Datagram Packet Switching',
              'Message Packet Switching',
              'Circuit Packet Switching',
              'Virtual Circuit Packet Switching',
            ],
            correctIndex: 3,
          ),
          QuizQuestion(
            question:
                'Why is packet switching primarily used on the Internet over other switching methods?',
            options: [
              'It requires less hardware',
              'It guarantees delivery order',
              'It is efficient, scalable, and resilient',
              'It uses dedicated paths',
            ],
            correctIndex: 2,
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
    completedLessons: 0,
    lessons: [
      Lesson(
        id: 'les_implementation_1',
        title: 'Lesson 1',
        subtitle: "Network Devices",
        readingTimeMinutes: 7,
        isCompleted: false,
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
