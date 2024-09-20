class AboutData {
  final String title;
  final String content;

  AboutData({required this.title, required this.content});
}

List<AboutData> aboutData = [
  AboutData(
    title: 'About the developer',
    content:
        'Hi, I\'m Desmond Adabe, the developer behind Welfare Fund. I\'m passionate about creating mobile applications'
        'with a focus on creating intuitive, user friendly applications. With expertise in mobile app development, '
        'backend integration, and a commitment to clean, efficient code, I specialize in turning complex problems into simple, '
        'elegant solutions\n\n Over the years, I have gained experience working with various programming languages and frameworks,'
        ' including Flutter for mobile development and Node.js for backend services. My goal is to build applications that not' 
        'only meet the needs of users but also create meaningful experiences.\n\n I am always open to learning new technologies'
        ' and improving my skills to stay ahead in this fast-evolving tech landscape. Driven by innovation and a deep passion for'
        'technology, I strive to deliver high-quality, scalable solutions that make a difference. \n\n '
  ),
  AboutData(
    title: '\t\t\tSkills and expertise',
    content: '• Mobile app development (Flutter)\n • Backend development (Node.js)\n • Augmented Reality development ',
  )
];
