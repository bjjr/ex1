package converters;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import domain.Skel;

@Component
@Transactional

// TODO Replace Skel in this converter

public class SkelToStringConverter implements Converter<Skel, String>{
	
	@Override
	public String convert(Skel skel) {
		String res;
		
		if (skel == null) {
			res = null;
		} else {
			res = String.valueOf(skel.getId());
		}
		
		return res;
	}
	
}
