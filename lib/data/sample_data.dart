// lib/data/sample_data.dart

import '../models/app_models.dart';
import 'package:ar_elearning/data/network_svgs.dart';

final List<LearningModule> sampleModules = [
  LearningModule(
    id: 'Module 1',
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
    id: 'Module 2',
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
                'Different medias have different properties like bandwidth, delay, cost and ease of installation and maintenance. Transmission media is also called Communication channel. Transmission media is broadly classified into two groups',
          ),
          LessonSection(
            heading: 'GUIDED TRANSMISSION MEDIA',
            body:
                'These are the cables that are tangible or have physical existence and are limited by the physical geography.',
          ),
          LessonSection(
            heading: 'Twisted Pair',
            body:
                'A twisted pair consists of two conductors (normally copper), each with its own plastic insulation, twisted together. One of the wires is used to carry signals to the receiver and the other is used only as a ground reference. It is most effectively used in systems that use a balanced line method of transmission.',
          ),
          LessonSection(
            heading: 'RJ45 Connector',
            body: 'Connector for twisted pair cable.\n',
          ),
          LessonSection(
              heading: 'Straight-Through Cable',
              body:
                  'Used to connect a host to a switch or hub, or a router to a switch or hub.\n'),
          LessonSection(
            heading: 'Cross Over Cable',
            body:
                'Crossover cables can be used to connect these devices: Switch to switch, Hub to hub, PC to PC.',
          ),
          LessonSection(
            heading: 'Coaxial Cable',
            body:
                'Coaxial Cable consists of 2 conductors. The inner conductor is held inside an insulator with the other conductor woven around it providing a shield. An insulating protective coating called a jacket covers the outer conductor.',
          ),
          LessonSection(
            heading: 'BNC Connectors',
            body: 'Connectors used to connect Coaxial cable.',
          ),
          LessonSection(
            heading: 'Optical Fiber',
            body:
                'Optical fiber is a cable that accepts and transports signals in the form of light. Optical fiber consists of thin glass fiber that can carry information at frequencies in the visible light spectrum.',
          ),
          LessonSection(
            heading: 'Optical Transmission Modes',
            body:
                'Optical fiber supports different transmission modes depending on the size of the core and how light travels through it. The three main modes are Step Index, Grade Index, and Single Mode. Each differs in how light rays travel and reflect within the fiber core.',
          ),
          LessonSection(
              heading: 'Step Index Mode',
              body:
                  'Step Index has a large core where light rays tend to bounce around, reflecting off the cladding inside the core. This causes some rays to take a longer or shorter path through the core.\n'),
          LessonSection(
              heading: 'Grade Index Mode',
              body:
                  'Grade Index has a gradual change in the Core\'s Refractive Index. This causes the light rays to be gradually bent back into the core path.\n'),
          LessonSection(
            heading: 'Single Mode',
            body:
                'Single Mode has separate distinct Refractive Indexes for the cladding and core. It has a much smaller core that allows only one mode of light to propagate, resulting in less signal distortion and allowing data to travel longer distances.',
          ),
          LessonSection(
            heading: 'UNGUIDED TRANSMISSION MEDIA',
            body:
                'Unguided transmission media refers to wireless transmission that transports electromagnetic waves without the use of a physical conductor. Signals are broadcast through air, water, or vacuum. It is classified based on the frequency range and the method of propagation used to transmit signals from sender to receiver.',
          ),
          LessonSection(
            heading: 'Ground-wave propagation',
            body:
                'It follows the curvature of the Earth. Ground Waves have carrier frequencies up to 2MHz. AM radio is an example of Ground Wave Propagation.\n',
          ),
          LessonSection(
              heading: 'Sky-wave propagation',
              body:
                  'Bounces off of the Earth\'s Ionospheric Layer in the upper atmosphere. Because it depends on the Earth\'s ionosphere, it changes with weather and time of day.\n'),
          LessonSection(
            heading: 'Line-of-sight propagation',
            body:
                'It transmits exactly in the line of sight. The receive station must be in the view of the transmit station. It is sometimes called Space Waves or Tropospheric Propagation.\n',
          ),
          LessonSection(
            heading: 'TRANSMISSION MEDIA PROBLEMS AND IMPAIRMENT',
            body:
                'When signals travel through a transmission medium, they are subject to various forms of impairment that degrade the quality of the received signal. The four major types of transmission impairments are Attenuation Distortion, Crosstalk, Echo or Signal Return, and Noise.',
          ),
          LessonSection(
            heading: 'Attenuation Distortion',
            body:
                'Attenuation results in loss of energy. When a signal travels through a medium, it loses some of its energy in overcoming the resistance of the medium.\n',
          ),
          LessonSection(
            heading: 'Crosstalk',
            body:
                'Crosstalk is when one line induces a signal into another line. In voice communications, we often hear this as another conversation going on in the background.\n',
          ),
          LessonSection(
            heading: 'Echo or Signal Return',
            body:
                'The signal arriving at the end of a transmission line should be fully absorbed otherwise it will be reflected back down the line to the sender and appear as an Echo. Echo Suppressors are often fitted to transmission lines to reduce this effect.\n',
          ),
          LessonSection(
            heading: 'Noise',
            body:
                'Noise is any unwanted signal that is mixed or combined with the original signal during transmission. Due to noise the original signal is altered and signal received is not same as the one sent. Noise is sharp quick spikes on the signal caused from electromagnetic interference, lightning, sudden power switching, electromechanical switching, etc.\n',
          ),
          LessonSection(
            heading: 'CHANNEL CAPACITY',
            body:
                'The maximum rate at which data can be transmitted over a given communication path, or channel, under given conditions is referred to as the channel capacity.\n'
                'There are four concepts here that we are trying to relate to one another:\n'
                '- Data rate\n'
                '- Bandwidth\n'
                '- Noise\n'
                '- Error rate',
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
    id: 'Module 3',
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
            heading: 'HUB',
            body:
                'A hub is the device that connects all the segments of the network together in a star topology Ethernet network. Every device in the network connects directly to the hub through a single cable and is used to connect multiple devices without segmenting a network.',
          ),
          LessonSection(
            heading: 'REPEATER',
            body:
                'A repeater is a network device that amplifies or regenerates a signal so that it can travel longer distances without degradation. When a signal weakens as it travels through a medium, the repeater receives it and retransmits it at its original strength. Repeaters operate at the Physical Layer (Layer 1) of the OSI model and are commonly used to extend the range of a network segment.',
          ),
          LessonSection(
            heading: 'MODEM',
            body:
                'A modem is a device that modulates digital data onto an analog carrier for transmission over an analog medium and then demodulates from the analog carrier to a digital signal again at the receiving end. A term modem is actually an acronym that stands for MOdulator/DEModulator.',
          ),
          LessonSection(
            heading: 'Types of Modem',
            body:
                'There are several types of modems used depending on the connection medium and use case:\n'
                '- External Modem: a standalone device that connects externally to a computer.\n'
                '- Router/Modem Combo: combines both modem and router functionality in one unit.\n'
                '- Integrated Modem: built into the computer via USB or PCI card.\n'
                '- Cable, DSL, Fiber, and Dial-up Modems: categorized by the type of internet connection they support.',
          ),
          LessonSection(
            heading: 'External modem',
            body:
                'An external modem is a standalone modem that does not contain a router. It connects to a single computer through a USB or Ethernet port and requires a separate router if multiple devices need to share the connection.',
          ),
          LessonSection(
            heading: 'Router/Modem Combo',
            body:
                'A router/modem combo is a modem that is contained within a router, which allows multiple computers and devices to connect within one network. It simplifies setup by combining two devices into one unit, reducing the number of cables and hardware needed.',
          ),
          LessonSection(
            heading: 'Integrated modem',
            body:
                'An integrated modem is a modem that is contained within a computer, usually by USB or as a PCI card. It is built directly into the system, eliminating the need for an external device and saving desk space.',
          ),
          LessonSection(
            heading: 'Cable, DSL, Fiber, Dial-up Modems',
            body:
                'These modems are classified by the type of internet service they support:\n'
                '- Dial-up Modem: uses a standard telephone line to establish a connection. It is the oldest and slowest type with speeds up to 56 Kbps.\n'
                '- DSL Modem: uses a digital subscriber line over telephone wiring to provide faster speeds than dial-up while keeping the phone line available.\n'
                '- Cable Modem: connects through a cable TV line and offers higher speeds suitable for home broadband use.\n'
                '- Fiber Modem (ONT): used with fiber-optic internet connections, converting optical signals to digital data for extremely fast and reliable internet access.',
          ),
          LessonSection(
            heading: 'NETWORK INTERFACE CARD (NIC)',
            body:
                'A Network Interface Card (NIC) is installed in your computer to connect, or interface, your computer to the network. It provides the physical, electrical, and electronic connections to the network media. Each NIC is assigned a unique hardware identifier known as a MAC address, which is used to identify the device on the network. NICs can support wired connections via Ethernet or wireless connections via Wi-Fi.',
          ),
          LessonSection(
            heading: 'BRIDGE',
            body:
                'A bridge—specifically, a transparent bridge—is a network device that connects two similar network segments together. Its primary function is to keep traffic separated on either side of the bridge, breaking up collision domains. Bridges operate at the Data Link Layer (Layer 2) of the OSI model and use MAC addresses to filter and forward traffic, improving overall network performance by reducing unnecessary data transmission.',
          ),
          LessonSection(
            heading: 'SWITCH',
            body:
                'Switches connect multiple segments of a network together much like hubs do, but with three significant differences — a switch recognizes frames and pays attention to the source and destination MAC address of the incoming frame as well as the port on which it was received. Unlike hubs, switches forward data only to the specific device it is intended for rather than broadcasting to all ports. This reduces network congestion, improves security, and increases overall efficiency. Switches operate at the Data Link Layer (Layer 2) of the OSI model.',
          ),
          LessonSection(
            heading: 'WIRELESS ACCESS POINT (AP)',
            body:
                'A wireless access point (AP) allows mobile users to connect to a wired network wirelessly via radio frequency technologies. Using wireless technologies, APs also allow wired networks to connect to each other and are basically the wireless equivalent of hubs or switches because they can connect multiple wireless and often wired devices together to form a network. APs are commonly used in homes, offices, and public spaces to extend wireless network coverage.',
          ),
          LessonSection(
            heading: 'ROUTER',
            body:
                'A router is a network device used to connect many, sometimes disparate, network segments together, combining them into what we call an internetwork. Routers operate at the Network Layer (Layer 3) of the OSI model and use IP addresses to determine the best path for forwarding data packets to their destination. They are essential for connecting local networks to the internet and for directing traffic efficiently across large and complex networks.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question:
                'Which network device connects all segments of a star topology Ethernet network and does not segment traffic?',
            options: ['Switch', 'Router', 'Hub', 'Bridge'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'A repeater is used in a network primarily to perform which of the following functions?',
            options: [
              'Filter MAC addresses',
              'Regenerate weakened signals',
              'Assign IP addresses',
              'Encrypt data'
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'What does the acronym MODEM stand for in networking terminology?',
            options: [
              'Media Output Device for Electronic Media',
              'Modulator/Demodulator',
              'Multiple Output Data Exchange Module',
              'Managed Output Data Encryption Module',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Which type of modem is built directly into a computer through USB or as a PCI card?',
            options: [
              'External modem',
              'Router/Modem Combo',
              'Cable modem',
              'Integrated modem'
            ],
            correctIndex: 3,
          ),
          QuizQuestion(
            question:
                'Which modem type converts optical signals to digital data and is used with the fastest type of internet connection?',
            options: [
              'DSL Modem',
              'Cable Modem',
              'Fiber Modem (ONT)',
              'Dial-up Modem'
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'What unique hardware identifier does a Network Interface Card use to identify a device on the network?',
            options: [
              'IP address',
              'MAC address',
              'Serial number',
              'Port number'
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'At which OSI layer does a bridge operate, using MAC addresses to filter and forward network traffic?',
            options: [
              'Physical Layer',
              'Network Layer',
              'Data Link Layer',
              'Transport Layer'
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'Unlike a hub, a switch improves network performance by forwarding data in which specific manner?',
            options: [
              'Broadcasts to all ports equally',
              'Only to the intended destination port',
              'Through the router first',
              'Based on IP addresses only',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'A Wireless Access Point (AP) is considered the wireless equivalent of which wired network devices?',
            options: [
              'Routers and modems',
              'Bridges and repeaters',
              'Hubs or switches',
              'NICs and bridges'
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'At which OSI layer does a router operate, using IP addresses to determine the best path for forwarding packets?',
            options: [
              'Data Link Layer',
              'Physical Layer',
              'Transport Layer',
              'Network Layer'
            ],
            correctIndex: 3,
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
            heading: 'INTRODUCING IP ADDRESSES',
            body:
                '	An IP address is a number that uniquely identifies every host on an IP network. IP addresses operate at the Network layer of the TCP/IP protocol stack, so they’re independent of lower-level addresses, such as MAC addresses (MAC stands for Media Access Control).\n'
                '	IP addresses are 32-bit binary numbers, which means that, theoretically,a maximum of something in the neighborhood of 4 billion unique hostaddresses can exist throughout the Internet. You’d think that’d be enough, but TCP/IP places certain restrictions on how IP addresses are allocated.',
          ),
          LessonSection(
            heading: 'Networks and Hosts ',
            body:
                'IP stands for Internet Protocol, and its primary purpose is to enable communications between networks.',
          ),
          LessonSection(
            heading: '32-bit IP address consists of two parts',
            body:
                'Every 32-bit IP address is divided into two logical sections: the network ID and the host ID. The network ID identifies the specific network, while the host ID identifies a particular device within that network. This structure allows data to be routed efficiently across interconnected networks.',
          ),
          LessonSection(
            heading: 'The network ID (or network address)',
            body:
                ' Identifies the network on which a host computer can be found.',
          ),
          LessonSection(
            heading: 'The host ID (or host address)',
            body:
                'Identifies a specific device on the network indicated by the network ID.',
          ),
          LessonSection(
            heading: 'The Dotted-Decimal Notation ',
            body:
                'IP addresses are usually represented in a format known as dotted-decimal notation. In dotted-decimal notation, each group of eight bits, known as an octet, is represented by its decimal equivalent',
          ),
          LessonSection(
            heading: 'CLASSIFYING IP ADDRESSES',
            body:
                'To accommodate networks of different sizes, IPv4 addresses are divided into classes. The most commonly used classes are Class A, Class B, and Class C. Each class allocates a different number of bits for the network ID and host ID, determining the number of available networks and hosts.',
          ),
          LessonSection(
            heading: 'Class A addresses ',
            body:
                'Class A addresses are designed for very large networks. In a Class A address, the first octet of the address is the network ID, and the remaining three octets are the host ID.',
          ),
          LessonSection(
            heading: 'Class B addresses ',
            body:
                'In a Class B address, the first two octets of the IP address are used as the network ID, and the second two octets are used as the host ID. Thus, a Class B address comes close to my hypothetical scheme of splitting the address down the middle, using half for the network ID and half for the host ID',
          ),
          LessonSection(
            heading: 'Class C addresses',
            body:
                'In a Class C address, the first three octets are used for the network ID, and the fourth octet is used for the host ID. With only eight bits for the host ID, each Class C network can accommodate only 254 hosts. However, with 24 network ID bits, Class C addresses allow for more than 2 million networks.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'What does IP stand for?',
            options: [
              'Internet Protocol',
              'Internal Program',
              'Internet Provider',
              'Information Process',
            ],
            correctIndex: 0,
          ),
          QuizQuestion(
            question: 'What is the primary purpose of IP?',
            options: [
              'Store files',
              'Enable communication between networks',
              'Encrypt data',
              'Manage user accounts',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'An IP address uniquely identifies a _____ on an IP network.',
            options: [
              'Website',
              'Router only',
              'Host',
              'Cable',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'How many bits are in an IPv4 address?',
            options: [
              '16 bits',
              '32 bits',
              '64 bits',
              '128 bits',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'A 32-bit IP address consists of which two parts?',
            options: [
              'Network ID and Host ID',
              'MAC ID and Device ID',
              'Port ID and Network ID',
              'Host ID and Gateway ID',
            ],
            correctIndex: 0,
          ),
          QuizQuestion(
            question: 'What does the network ID identify?',
            options: [
              'A specific user',
              'A specific application',
              'The network on which a host is located',
              'The operating system',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'What does the host ID identify?',
            options: [
              'A specific device on a network',
              'A network administrator',
              'An internet service provider',
              'A website domain',
            ],
            correctIndex: 0,
          ),
          QuizQuestion(
            question: 'IP addresses are commonly written in which format?',
            options: [
              'Binary notation',
              'Hexadecimal notation',
              'Dotted-decimal notation',
              'Scientific notation',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'In a Class B IP address, how many octets are used for the network ID?',
            options: [
              '1',
              '2',
              '3',
              '4',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'In a Class C IP address, which octet is used for the host ID?',
            options: [
              'First octet',
              'Second octet',
              'Third octet',
              'Fourth octet',
            ],
            correctIndex: 3,
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
            heading: 'What is Subnetting?',
            body:
                'Subnetting is a technique that lets network administrators use the 32 bits available in an IP address more efficiently by creating networks that aren’t limited to the scales provided by Class A, B, and C IP addresses. With subnetting, you can create networks with more realistic host limits',
          ),
          LessonSection(
            heading: 'What is a Subnet?',
            body:
                'A subnet is a network that falls within another (Class A, B, or C) network. Subnets are created by using one or more of the Class A, B, or C host bits to extend the network ID.',
          ),
          LessonSection(
            heading: 'Subnet masks',
            body:
                'A subnet mask is a 32-bit number that separates the network portion of an IP address from the host portion. It works by using consecutive 1s to represent the network and subnet bits, and 0s to represent the host bits. Common subnet masks include 255.0.0.0 for Class A, 255.255.0.0 for Class B, and 255.255.255.0 for Class C networks.',
          ),
          LessonSection(
            heading: 'HOW TO CREATE SUBNETS?',
            body:
                '1. Identify the class of the IP address.\n2. Find the number of borrowed bits.\n3. Solve the value of ∆.\n4. Find the new subnet mask.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'What is subnetting?',
            options: [
              'A method of combining networks',
              'A technique for dividing a network into smaller networks',
              'A process of encrypting data',
              'A type of routing protocol',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'What is the main purpose of subnetting?',
            options: [
              'To increase internet speed',
              'To reduce the number of IP addresses',
              'To use IP addresses more efficiently',
              'To replace routers',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'A subnet is a network that falls within what?',
            options: [
              'Another Class A, B, or C network',
              'A MAC address',
              'A router table',
              'A DNS server',
            ],
            correctIndex: 0,
          ),
          QuizQuestion(
            question:
                'Subnets are created by using one or more _____ bits to extend the network ID.',
            options: [
              'Network',
              'Host',
              'Parity',
              'Gateway',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'What is a subnet mask?',
            options: [
              'A type of IP address',
              'A network cable',
              'A 32-bit number that separates network and host portions',
              'A routing protocol',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'In a subnet mask, the network and subnet bits are represented by:',
            options: [
              '0s',
              '1s',
              '2s',
              '8s',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'In a subnet mask, the host bits are represented by:',
            options: [
              '0s',
              '1s',
              '2s',
              '8s',
            ],
            correctIndex: 0,
          ),
          QuizQuestion(
            question: 'What is the default subnet mask for a Class B network?',
            options: [
              '255.0.0.0',
              '255.255.0.0',
              '255.255.255.0',
              '255.255.255.255',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'What is the first step in creating subnets?',
            options: [
              'Find the new subnet mask',
              'Solve the value of Δ',
              'Identify the class of the IP address',
              'Find the host address',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'After finding the number of borrowed bits, what is the next step?',
            options: [
              'Find the new subnet mask',
              'Solve the value of Δ',
              'Identify the network ID',
              'Determine the host name',
            ],
            correctIndex: 1,
          ),
        ],
      ),
    ],
  ),
  LearningModule(
    id: 'Module 4',
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
            heading: 'Home Network',
            body:
                '	The most common home network is Ethernet; it’s a very popular LAN (Local Area Network) technology due to its inexpensive setup cost and reasonably fast speed. The other types of network are Token Ring, LocalTalk, and FDDI, but they are not important here. The speed (data transfer rate) of an Ethernet can be 10Mbps (Ethernet), 100Mbps (Fast Ethernet) and 1000Mbps (Gigabit Ethernet). Mbps is called Megabits per seconds',
          ),
          LessonSection(
            heading: 'DIRECT CONNECTION OF TWO COMPUTERS',
            body:
                '	The two major network devices required are: crossover cable and network cards. This is wired connection approach, it’s effective and simple way if you want to connect the computers temporary. If the network card on computers supports auto MDI/MDIX feature, you could use crossover or straight through network cable to connect both computers. If not, crossover cable is needed',
          ),
          LessonSection(
            heading: 'Network configuration\n\n',
            body: 'Computer A:\n'
                'IP Address: 192.168.36.1\n'
                'Subnet mask: 255.255.255.0\n'
                'Gateway: [leave-it-blank]\n'
                'DNS Servers: [leave-it-blank]\n\n'
                'Computer B:\n'
                'IP Address: 192.168.36.2\n'
                'Subnet mask: 255.255.255.0\n'
                'Gateway: [leave-it-blank]\n'
                'DNS Servers: [leave-it-blank]',
          ),
          LessonSection(
            heading: 'Peer to Peer Configuration',
            body:
                '1. Connect the two computer using a cross-over cable. Note: If cable is not available, you can wirelessly connect the 2 computers using the hotspot f your mobile phone. (There should be NO red x mark)\n\n'
                '2. Control Panel ->Network and Internet-> Network & Sharing Center ->Change Adapter Settings -> Local Area Connection/Ethernet -> Ethernet Properties IPv4 -> Use the following IP add: 192.168.1.1 (the last number in the IP add is your seat #)\n\n'
                '3. Disable the windows firewall.\n\n'
                '4. Type at cmd: ping (IP add of the other computer ex:192.168.1.2) to check connectivity\n\n'
                'Sharing/Accessing Folder: Both computer can access the folder of the other computer.\n'
                'a.) Desktop ->Create new folder->share folder.\n'
                'b.) Access the shared folder of the other computer.',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'What is the most common type of home network?',
            options: [
              'Token Ring',
              'Ethernet',
              'FDDI',
              'LocalTalk',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'Why is Ethernet popular in home networks?',
            options: [
              'It is very expensive',
              'It requires no hardware',
              'It has low setup cost and good speed',
              'It only works wirelessly',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'What does LAN stand for?',
            options: [
              'Large Area Network',
              'Local Access Network',
              'Local Area Network',
              'Linked Area Network',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Which Ethernet standard has a speed of 1000 Mbps?',
            options: [
              'Ethernet',
              'Fast Ethernet',
              'Gigabit Ethernet',
              'Token Ring',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'What does Mbps mean?',
            options: [
              'Megabytes per second',
              'Megabits per second',
              'Millions per second',
              'Memory bits per second',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Which two major devices are required for a direct connection between two computers?',
            options: [
              'Router and modem',
              'Switch and hub',
              'Crossover cable and network cards',
              'Access point and repeater',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'What type of cable is commonly used to directly connect two computers if auto MDI/MDIX is not supported?',
            options: [
              'Straight-through cable',
              'Fiber optic cable',
              'Coaxial cable',
              'Crossover cable',
            ],
            correctIndex: 3,
          ),
          QuizQuestion(
            question:
                'What is the IP address assigned to Computer A in the example configuration?',
            options: [
              '192.168.36.1',
              '192.168.36.2',
              '255.255.255.0',
              '192.168.1.1',
            ],
            correctIndex: 0,
          ),
          QuizQuestion(
            question:
                'What subnet mask is used for both Computer A and Computer B?',
            options: [
              '255.0.0.0',
              '255.255.0.0',
              '255.255.255.0',
              '255.255.255.255',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'Which command is used to test connectivity between two computers?',
            options: [
              'ipconfig',
              'ping',
              'tracert',
              'netstat',
            ],
            correctIndex: 1,
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
            heading:
                'CONFIGURING OF IP ADDRESS AND OTHER NETWORK INFORMATION ON WINDOWS ',
            body:
                '	IP address must be configured on computer in order to communicate with other computers, because this IP address is the standard address understood by computers and other networking devices in networking world. We can configure IP address, subnet mask, gateway and DNS servers manually on computer, we can also configure computer to obtain IP address and other network information from DHCP server (most of the time is configured on router).',
          ),
          LessonSection(
            heading: 'Procedure:',
            body: '1. Go to Start and click on Control Panel.\n\n'
                '2. Click View network status and tasks in Control Panel window\n\n'
                '3. Network and Sharing Center window will appear, and then click change adapter settings.\n\n'
                '4. Network Connections window will appear. Here you can right click on the network adapter (can be wireless adapter or wired Ethernet adapter) that you wish to configure and click Properties\n\n'
                '5. In the Network Connection Properties window, tick on Internet Protocol Version 4 (TCP/IPv4) and click Properties\n\n'
                '6. Assigning IP Address - After clicking properties, TCP/IPv4 window appear. (See figure 4.2.5) For manual IP Assigning we can now key in the IP address, Subnet mask, Default gateway and DNS servers. IP address of your computer must be unique. None of the 2 computers in the same network can share same IP address, because it will cause IP address conflict',
          ),
          LessonSection(
            heading: 'PHYSICAL NETWORK SETUP',
            body:
                '	Connect the WAN port on router to your cable/DSL modem using straight cable, then connect computers‟ network card to router’s LAN ports using straight cable also. You can connect up to 4 computers to this router\n\n'
                '	Power on the router after finish connecting, you should be able to see the WAN and LAN lights on the router. Also, you need to ensure that your DSL/Cable modem is configured in bridge mode, so that it can work well after connecting to router. ',
          ),
        ],
        quizQuestions: [
          QuizQuestion(
            question: 'Why must an IP address be configured on a computer?',
            options: [
              'To increase storage capacity',
              'To communicate with other computers on a network',
              'To improve monitor resolution',
              'To install applications',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Which of the following network information can be configured manually?',
            options: [
              'IP address, subnet mask, gateway, and DNS servers',
              'CPU speed and RAM',
              'Monitor settings',
              'Keyboard layout only',
            ],
            correctIndex: 0,
          ),
          QuizQuestion(
            question:
                'What device commonly provides IP addresses automatically to computers?',
            options: [
              'Switch',
              'Hub',
              'DHCP Server',
              'Repeater',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'What is the first step in configuring network settings in Windows?',
            options: [
              'Open Command Prompt',
              'Go to Start and click Control Panel',
              'Restart the computer',
              'Open File Explorer',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Which option should you click in Control Panel to view network settings?',
            options: [
              'Programs and Features',
              'Device Manager',
              'View network status and tasks',
              'System Information',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'Which protocol must be selected before clicking Properties to configure an IP address?',
            options: [
              'HTTP',
              'FTP',
              'Internet Protocol Version 4 (TCP/IPv4)',
              'SMTP',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'What can happen if two computers on the same network use the same IP address?',
            options: [
              'Faster internet connection',
              'IP address conflict',
              'Improved security',
              'Automatic subnetting',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'In a physical network setup, the router WAN port is connected to the:',
            options: [
              'Printer',
              'Computer LAN port',
              'Cable/DSL modem',
              'Network switch',
            ],
            correctIndex: 2,
          ),
          QuizQuestion(
            question:
                'What type of cable is used to connect computers to the router LAN ports?',
            options: [
              'Crossover cable',
              'Straight cable',
              'Fiber cable',
              'Coaxial cable',
            ],
            correctIndex: 1,
          ),
          QuizQuestion(
            question:
                'Before using the router with a DSL/Cable modem, the modem should be configured in:',
            options: [
              'Access Point mode',
              'Safe mode',
              'Bridge mode',
              'Wireless mode',
            ],
            correctIndex: 2,
          ),
        ],
      ),
    ],
  ),
];

final List<Model3D> sampleModels = [
  Model3D(
    id: 'mdl_modem',
    name: 'Modem',
    description:
        'A modem is a network device that converts digital signals from a computer into analog signals for transmission over telephone or cable lines, and vice versa.',
    category: 'Networking',
    learningObjective:
        'Understand how a modem enables internet connectivity by converting and transmitting data between ISP and local devices.',
    relatedModuleId: 'mod_implementation',
    thumbnailSvg: NetworkSvgs.modem,
  ),
  Model3D(
    id: 'mdl_networkSwitch',
    name: 'Network Switch',
    description:
        'A network switch is a device that connects multiple devices within a local area network (LAN) and intelligently forwards data only to the intended recipient device.',
    category: 'Networking',
    learningObjective:
        'Understand how a network switch efficiently manages data traffic by directing packets to specific devices in a LAN.',
    relatedModuleId: 'mod_implementation',
    thumbnailSvg: NetworkSvgs.networkSwitch,
  ),
  Model3D(
    id: 'mdl_hub',
    name: 'Network Hub',
    description:
        'A network hub is a basic networking device that connects multiple devices in a local area network (LAN) and broadcasts data to all connected devices, regardless of the intended recipient.',
    category: 'Networking',
    learningObjective:
        'Understand how a network hub works by broadcasting incoming data to all connected devices and compare it with a network switch.',
    relatedModuleId: 'mod_implementation',
    thumbnailSvg: NetworkSvgs.hub,
  ),
  Model3D(
    id: 'mdl_repeater',
    name: 'Network Repeater',
    description:
        'A network repeater is a device that regenerates and amplifies weak or degraded signals to extend the distance of a network.',
    category: 'Networking',
    learningObjective:
        'Understand how a repeater improves signal strength and extends network coverage over long distances.',
    relatedModuleId: 'mod_implementation',
    thumbnailSvg: NetworkSvgs.repeater,
  ),
  Model3D(
    id: 'mdl_rj45',
    name: 'RJ45 Connector',
    description:
        'An RJ45 connector is a standard network interface used to terminate Ethernet cables and connect devices to a local area network (LAN).',
    category: 'Networking',
    learningObjective:
        'Understand the role of RJ45 connectors in establishing wired Ethernet connections between network devices.',
    relatedModuleId: 'mod_transmission',
    thumbnailSvg: NetworkSvgs.rj45,
  ),
  Model3D(
    id: 'mdl_coaxialCable',
    name: 'Coaxial Cable',
    description:
        'A coaxial cable is a type of transmission medium used to carry high-frequency electrical signals for cable television, internet, and radio communications. It consists of a central conductor, insulating layer, metallic shield, and outer jacket.',
    category: 'Networking',
    learningObjective:
        'Understand how coaxial cables transmit data signals and their role in broadband and cable network systems.',
    relatedModuleId: 'mod_transmission',
    thumbnailSvg: NetworkSvgs.coaxialCable,
  ),
  Model3D(
    id: 'mdl_opticalFiber',
    name: 'Optical Fiber',
    description:
        'Optical fiber is a high-speed transmission medium that uses light pulses through thin glass or plastic fibers to transmit data over long distances with minimal signal loss.',
    category: 'Networking',
    learningObjective:
        'Understand how optical fiber transmits data using light and why it is used for high-speed and long-distance communication networks.',
    relatedModuleId: 'mod_transmission',
    thumbnailSvg: NetworkSvgs.opticalFiber,
  ),
  Model3D(
    id: 'mdl_smartphone',
    name: 'Smartphone',
    description:
        'A smartphone is a mobile device that combines cellular communication, computing capabilities, and internet connectivity, allowing users to make calls, access the web, and run applications.',
    category: 'Networking',
    learningObjective:
        'Understand how smartphones connect to cellular networks and Wi-Fi to access communication and internet services.',
    relatedModuleId: 'mod_fundamentals',
    thumbnailSvg: NetworkSvgs.smartphone,
  ),
  Model3D(
    id: 'mdl_serverRack',
    name: 'Server Rack',
    description:
        'A server rack is a standardized frame or cabinet used to organize, mount, and secure servers, networking devices, and other computing hardware in data centers.',
    category: 'Networking',
    learningObjective:
        'Understand how server racks are used to organize and manage network infrastructure and computing hardware efficiently in data centers.',
    relatedModuleId: 'mod_fundamentals',
    thumbnailSvg: NetworkSvgs.serverRack,
  ),
  Model3D(
    id: 'mdl_laptop',
    name: 'Laptop',
    description:
        'A laptop is a portable personal computer used to access networks, run applications, and perform computing tasks while on the move.',
    category: 'Networking',
    learningObjective:
        'Understand how laptops connect to wired and wireless networks for communication and data access.',
    relatedModuleId: 'mod_fundamentals',
    thumbnailSvg: NetworkSvgs.laptop,
  ),
  Model3D(
    id: 'mdl_desktop',
    name: 'Desktop Computer',
    description:
        'A desktop computer is a stationary computing device that connects to a network to access internet services and shared resources.',
    category: 'Networking',
    learningObjective:
        'Understand how desktop computers function as fixed network endpoints in a LAN or WAN.',
    relatedModuleId: 'mod_fundamentals',
    thumbnailSvg: NetworkSvgs.desktop,
  ),
  Model3D(
    id: 'mdl_router',
    name: 'Router',
    description:
        'A router is a networking device that directs data between different networks, such as connecting a local network to the internet.',
    category: 'Networking',
    learningObjective:
        'Understand how routers manage and direct data traffic between networks.',
    relatedModuleId: 'mod_implementation',
    thumbnailSvg: NetworkSvgs.router,
  ),
  Model3D(
    id: 'mdl_access_point',
    name: 'Wireless Access Point',
    description:
        'A wireless access point allows devices to connect to a wired network using Wi-Fi technology.',
    category: 'Networking',
    learningObjective:
        'Understand how access points provide wireless connectivity to a local network.',
    relatedModuleId: 'mod_implementation',
    thumbnailSvg: NetworkSvgs.wirelessAccessPoint,
  ),
];
